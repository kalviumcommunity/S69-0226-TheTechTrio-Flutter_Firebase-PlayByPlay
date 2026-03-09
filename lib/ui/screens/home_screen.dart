import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/tournament.dart';
import '../../data/models/match.dart' as app_models;
import '../../data/services/tournament_service.dart';
import '../../data/services/match_service.dart';
import '../../data/services/seed_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local League Live'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            tooltip: 'Seed Mock Data',
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Seeding mock data...')),
              );
              await SeedService().seedMockData();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data seeded!')),
              );
              _loadTournament();
            },
          ),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'Organizer Login',
            onPressed: () {
              Navigator.pushNamed(context, '/scorer-dashboard');
            },
          ),
        ],
      ),
      body: _isLoadingTournament
          ? const Center(child: CircularProgressIndicator())
          : _currentTournament == null
              ? const Center(child: Text('No active tournament found.'))
              : _buildTournamentView(context),
    );
  }

  Widget _buildTournamentView(BuildContext context) {
    final t = _currentTournament!;
    final dateFormat = DateFormat('MMM d, yyyy');
    final dateString = t.startDate != null && t.endDate != null
        ? '${dateFormat.format(t.startDate!)} - ${dateFormat.format(t.endDate!)}'
        : 'Dates TBD';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tournament Header
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 4),
                  Text(t.location, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Text(dateString, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
        ),
        
        // Matches List
        Expanded(
          child: StreamBuilder<List<app_models.MatchModel>>(
            stream: _matchService.getMatchesForTournament(t.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error loading matches: ${snapshot.error}'));
              }
              
              final matches = snapshot.data ?? [];
              
              if (matches.isEmpty) {
                return const Center(child: Text('No matches scheduled yet.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final headerMatch = matches[index];
                  return _buildMatchCard(context, headerMatch);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMatchCard(BuildContext context, app_models.MatchModel match) {
    Color statusColor = Colors.grey;
    if (match.status == 'live') statusColor = Colors.red;
    if (match.status == 'finished') statusColor = Colors.green;

    final startTimeString = match.startTime != null 
        ? DateFormat('MMM d, h:mm a').format(match.startTime!) 
        : 'TBD';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/match-detail',
            arguments: match.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      match.status.toUpperCase(),
                      style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    startTimeString,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    match.teamAId.isNotEmpty ? match.teamAId : 'Team A', // we need TeamService for real names in future
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('vs', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    match.teamBId.isNotEmpty ? match.teamBId : 'Team B',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.stadium, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(match.venue, style: const TextStyle(color: Colors.grey)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
