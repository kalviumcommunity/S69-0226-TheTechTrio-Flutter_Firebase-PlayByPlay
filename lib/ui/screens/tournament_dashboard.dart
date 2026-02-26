import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'package:playbyplay/data/models/tournament.dart';
import '../../logic/auth_provider.dart';
import '../../logic/tournament_provider.dart';

class TournamentDashboard extends ConsumerWidget {
  const TournamentDashboard({super.key});

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final sportController = TextEditingController();
    final locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Tournament'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name (e.g. Summer Cup)')),
            TextField(controller: sportController, decoration: const InputDecoration(labelText: 'Sport (e.g. Football)')),
            TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Location')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final uid = ref.read(authStateProvider).value;
              if (uid == null || nameController.text.isEmpty) return;
              
              final newTourney = Tournament(
                id: const Uuid().v4(),
                name: nameController.text.trim(),
                sport: sportController.text.trim(),
                location: locationController.text.trim(),
                startDate: DateTime.now(), // Simplified for MVP
                endDate: DateTime.now().add(const Duration(days: 7)),
                createdBy: uid,
              );

              ref.read(tournamentControllerProvider).create(newTourney);
              Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentsAsync = ref.watch(myTournamentsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Tournaments')),
      body: tournamentsAsync.when(
        data: (tourneys) {
          if (tourneys.isEmpty) {
            return const Center(child: Text("You haven't created any tournaments yet."));
          }
          return ListView.builder(
            itemCount: tourneys.length,
            itemBuilder: (context, index) {
              final t = tourneys[index];
              return ListTile(
                title: Text(t.name),
                subtitle: Text('\${t.sport} • \${t.location}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.push('/tournament/\${t.id}', extra: t),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: \$e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
