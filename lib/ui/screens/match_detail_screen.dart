import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'package:playbyplay/data/models/match.dart';
import 'package:playbyplay/data/models/player_stat.dart';
import '../../logic/match_provider.dart';
import '../../logic/auth_provider.dart';

class MatchDetailScreen extends ConsumerWidget {
  final String matchId;

  const MatchDetailScreen({super.key, required this.matchId});

  void _showAddStatDialog(BuildContext context, WidgetRef ref, MatchModel match) {
    final playerNameCtrl = TextEditingController();
    final stat1Ctrl = TextEditingController();
    TeamSelection? selectedTeam;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Player Stat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: playerNameCtrl, decoration: const InputDecoration(labelText: 'Player Name')),
              DropdownButton<TeamSelection>(
                value: selectedTeam,
                hint: const Text("Select Team"),
                isExpanded: true,
                items: [
                  DropdownMenuItem(value: TeamSelection(match.teamAId, match.teamAName), child: Text(match.teamAName)),
                  DropdownMenuItem(value: TeamSelection(match.teamBId, match.teamBName), child: Text(match.teamBName)),
                ],
                onChanged: (val) => setState(() => selectedTeam = val),
              ),
              TextField(controller: stat1Ctrl, decoration: const InputDecoration(labelText: 'Goals / Runs'), keyboardType: TextInputType.number),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (playerNameCtrl.text.isEmpty || selectedTeam == null) return;
                final statVal = int.tryParse(stat1Ctrl.text) ?? 0;
                
                final stat = PlayerStat(
                  id: const Uuid().v4(),
                  matchId: match.id,
                  teamId: selectedTeam!.id,
                  playerName: playerNameCtrl.text.trim(),
                  stat1: statVal,
                );
                
                ref.read(matchControllerProvider).addStat(stat);
                Navigator.pop(ctx);
              },
              child: const Text('Add Stat'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchAsync = ref.watch(singleMatchProvider(matchId));
    final statsAsync = ref.watch(matchStatsProvider(matchId));
    final currentUserAsync = ref.watch(currentUserProfileProvider);

    // Only allow editing if user is Organizer or Scorer
    final canEdit = currentUserAsync.valueOrNull?.role == 'ORGANIZER' || currentUserAsync.valueOrNull?.role == 'SCORER';

    return Scaffold(
      appBar: AppBar(title: const Text('Match Details')),
      body: matchAsync.when(
        data: (match) {
          final stats = statsAsync.valueOrNull ?? [];
          final teamAStats = stats.where((s) => s.teamId == match.teamAId).toList();
          final teamBStats = stats.where((s) => s.teamId == match.teamBId).toList();

          return CustomScrollView(
            slivers: [
              // Scoreboard Header
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Column(
                    children: [
                      Text(match.status, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: Text(match.teamAName, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge)),
                          Text('\${match.scoreTeamA} - \${match.scoreTeamB}', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
                          Expanded(child: Text(match.teamBName, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(match.groundName),
                      // Scorer Controls
                      if (canEdit) ...[
                        const Divider(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add), label: const Text('Team A'),
                              onPressed: () => ref.read(matchControllerProvider).updateScore(match.id, match.scoreTeamA + 1, match.scoreTeamB),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add), label: const Text('Team B'),
                              onPressed: () => ref.read(matchControllerProvider).updateScore(match.id, match.scoreTeamA, match.scoreTeamB + 1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          children: [
                            if (match.status == 'NOT_STARTED')
                              OutlinedButton(onPressed: () => ref.read(matchControllerProvider).updateStatus(match.id, 'LIVE'), child: const Text('Start Match')),
                            if (match.status == 'LIVE')
                              OutlinedButton(onPressed: () => ref.read(matchControllerProvider).updateStatus(match.id, 'FINISHED'), child: const Text('End Match')),
                          ],
                        )
                      ]
                    ],

                  ),
                ),
              ),

              // Player Stats Lists
              const SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(child: Text('Player Stats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              ),
              
              if (stats.isEmpty)
                 const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(16), child: Text("No stats recorded yet.")))
              else
                 SliverList(
                   delegate: SliverChildBuilderDelegate(
                     (ctx, i) {
                        final s = stats[i];
                        final teamName = s.teamId == match.teamAId ? match.teamAName : match.teamBName;
                        return ListTile(
                          leading: CircleAvatar(child: Text(s.playerName[0].toUpperCase())),
                          title: Text(s.playerName),
                          subtitle: Text(teamName),
                          trailing: Text('Goals/Runs: \${s.stat1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        );
                     },
                     childCount: stats.length
                   )
                 ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: \$e')),
      ),
      floatingActionButton: canEdit && matchAsync.valueOrNull != null
          ? FloatingActionButton.extended(
              onPressed: () => _showAddStatDialog(context, ref, matchAsync.valueOrNull!),
              icon: const Icon(Icons.person_add),
              label: const Text('Add Stat'),
            )
          : null,
    );
  }
}

class TeamSelection {
  final String id;
  final String name;
  TeamSelection(this.id, this.name);
}
