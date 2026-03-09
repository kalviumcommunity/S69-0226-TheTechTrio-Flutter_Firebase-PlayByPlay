import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/tournament.dart';
import '../../data/models/match.dart' as app_models;
import '../../data/services/auth_service.dart';
import '../../data/services/tournament_service.dart';
import '../../data/services/match_service.dart';

class ScorerDashboardScreen extends StatefulWidget {
  const ScorerDashboardScreen({super.key});

  @override
  State<ScorerDashboardScreen> createState() => _ScorerDashboardScreenState();
}

class _ScorerDashboardScreenState extends State<ScorerDashboardScreen> {
  final AuthService _authService = AuthService();
  final TournamentService _tournamentService = TournamentService();
  final MatchService _matchService = MatchService();
  
  TournamentModel? _currentTournament;
  bool _isLoadingTournament = true;

  @override
  void initState() {
    super.initState();
    _loadTournament();
  }

  Future<void> _loadTournament() async {
    final tournament = await _tournamentService.getCurrentTournament();
    if (mounted) {
      setState(() {
        _currentTournament = tournament;
        _isLoadingTournament = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    await _authService.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/'); // Back to spectator home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scorer Dashboard'),
        backgroundColor: Colors.amber.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: _isLoadingTournament
          ? const Center(child: CircularProgressIndicator())
          : _currentTournament == null
              ? const Center(child: Text('No active tournament found to score.'))
              : _buildMatchesList(),
    );
  }

  Widget _buildMatchesList() {
    final t = _currentTournament!;
    
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: Colors.amber.withValues(alpha: 0.1),
          child: Text(
            'Select a match to start scoring',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<app_models.MatchModel>>(
            stream: _matchService.getMatchesForTournament(t.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              
              final matches = snapshot.data ?? [];
              
              if (matches.isEmpty) {
                return const Center(child: Text('No matches scheduled.'));
              }

              return ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  return _buildScoringMatchCard(context, matches[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScoringMatchCard(BuildContext context, app_models.MatchModel match) {
    Color statusColor = Colors.grey;
    if (match.status == 'live') statusColor = Colors.red;
    if (match.status == 'finished') statusColor = Colors.green;

    final startTimeString = match.startTime != null 
        ? DateFormat('MMM d, h:mm a').format(match.startTime!) 
        : 'TBD';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Icon(
          Icons.sports_cricket, 
          color: match.status == 'live' ? Colors.red : Colors.grey,
        ),
        title: Text('${match.teamAId} vs ${match.teamBId}', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$startTimeString • ${match.venue}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: statusColor),
          ),
          child: Text(
            match.status.toUpperCase(),
            style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/scoring',
            arguments: match.id,
          );
        },
      ),
    );
  }
}
