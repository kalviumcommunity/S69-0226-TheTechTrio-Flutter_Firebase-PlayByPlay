import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:playbyplay/data/models/tournament.dart';
import 'package:playbyplay/data/models/team.dart';
import 'package:playbyplay/data/models/match.dart';
import '../../logic/match_provider.dart';

class TournamentDetailScreen extends ConsumerWidget {
  final Tournament tournament;

  const TournamentDetailScreen({super.key, required this.tournament});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tournament.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Teams'),
              Tab(text: 'Matches'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _TeamsTab(tournament: tournament),
            _MatchesTab(tournament: tournament),
          ],
        ),
      ),
    );
  }
}

class _TeamsTab extends ConsumerWidget {
  final Tournament tournament;
  const _TeamsTab({required this.tournament});

  void _showAddTeam(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Team'),
        content: TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Team Name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isEmpty) return;
              final team = Team(
                id: const Uuid().v4(),
                tournamentId: tournament.id,
                name: nameCtrl.text.trim(),
              );
              ref.read(matchControllerProvider).createTeam(team);
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsync = ref.watch(tournamentTeamsProvider(tournament.id));
    return Scaffold(
      body: teamsAsync.when(
        data: (teams) => teams.isEmpty 
          ? const Center(child: Text("No teams added yet."))
          : ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, i) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.shield)),
                title: Text(teams[i].name),
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: \$e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTeam(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _MatchesTab extends ConsumerWidget {
  final Tournament tournament;
  const _MatchesTab({required this.tournament});

  void _showAddMatch(BuildContext context, WidgetRef ref, List<Team> availableTeams) {
    if (availableTeams.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add at least 2 teams first.')));
      return;
    }
    
    Team? teamA = availableTeams[0];
    Team? teamB = availableTeams[1];
    final groundCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Schedule Match'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Team>(
                value: teamA,
                isExpanded: true,
                items: availableTeams.map((t) => DropdownMenuItem(value: t, child: Text(t.name))).toList(),
                onChanged: (val) => setState(() => teamA = val),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Text('VS')),
              DropdownButton<Team>(
                value: teamB,
                isExpanded: true,
                items: availableTeams.map((t) => DropdownMenuItem(value: t, child: Text(t.name))).toList(),
                onChanged: (val) => setState(() => teamB = val),
              ),
              TextField(controller: groundCtrl, decoration: const InputDecoration(labelText: 'Ground / Field')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (teamA == null || teamB == null || teamA!.id == teamB!.id) {
                  return; // Cannot play against themselves
                }
                final match = MatchModel(
                  id: const Uuid().v4(),
                  tournamentId: tournament.id,
                  teamAId: teamA!.id,
                  teamBId: teamB!.id,
                  teamAName: teamA!.name,
                  teamBName: teamB!.name,
                  scoreTeamA: 0,
                  scoreTeamB: 0,
                  startTime: DateTime.now().add(const Duration(hours: 1)), // Mock schedule time
                  status: 'NOT_STARTED',
                  groundName: groundCtrl.text.isEmpty ? 'TBD' : groundCtrl.text.trim(),
                );
                ref.read(matchControllerProvider).createMatch(match);
                Navigator.pop(ctx);
              },
              child: const Text('Schedule'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesAsync = ref.watch(tournamentMatchesProvider(tournament.id));
    final teamsAsync = ref.watch(tournamentTeamsProvider(tournament.id)); // Need teams to pick from

    return Scaffold(
      body: matchesAsync.when(
        data: (matches) => matches.isEmpty
            ? const Center(child: Text("No matches scheduled yet."))
            : ListView.builder(
                itemCount: matches.length,
                itemBuilder: (ctx, i) {
                  final m = matches[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text('\${m.teamAName} vs \${m.teamBName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('\${m.groundName} • \${m.status}'),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: \$e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           // We need the current teams list to populate the dropdown
           final currentTeams = teamsAsync.valueOrNull ?? [];
           _showAddMatch(context, ref, currentTeams);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
