import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../logic/auth_provider.dart';
import '../../logic/match_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authStateProvider).value;
    final userProfile = ref.watch(currentUserProfileProvider).valueOrNull;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PlayByPlay Feed'),
          actions: [
            uid == null
                ? IconButton(
                    icon: const Icon(Icons.account_circle_outlined),
                    onPressed: () => context.push('/auth'),
                  )
                : PopupMenuButton<String>(
                    icon: const Icon(Icons.account_circle),
                    onSelected: (value) {
                      if (value == 'logout') {
                        ref.read(authControllerProvider.notifier).signOut();
                      } else if (value == 'tournaments') {
                        context.push('/tournaments');
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        enabled: false,
                        child: Text('\${userProfile?.name ?? "..."} (\${userProfile?.role ?? "..."})'),
                      ),
                      const PopupMenuDivider(),
                      if (userProfile?.role == 'ORGANIZER')
                        const PopupMenuItem<String>(
                          value: 'tournaments',
                          child: Text('My Tournaments'),
                        ),
                      const PopupMenuItem<String>(
                        value: 'logout',
                        child: Text('Log out'),
                      ),
                    ],
                  ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'LIVE'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Finished'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MatchListFeed(status: 'LIVE'),
            MatchListFeed(status: 'NOT_STARTED'),
            MatchListFeed(status: 'FINISHED'),
          ],
        ),
      ),
    );
  }
}

class MatchListFeed extends ConsumerWidget {
  final String status;
  const MatchListFeed({super.key, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesAsync = ref.watch(matchesByStatusProvider(status));

    return matchesAsync.when(
      data: (matches) {
        if (matches.isEmpty) {
          return Center(child: Text('No ${status.replaceAll('_', ' ').toLowerCase()} matches at the moment.'));
        }
        return ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, index) {
            final m = matches[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(m.teamAName, overflow: TextOverflow.ellipsis)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('${m.scoreTeamA} - ${m.scoreTeamB}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    Expanded(child: Text(m.teamBName, textAlign: TextAlign.right, overflow: TextOverflow.ellipsis)),
                  ],
                ),
                subtitle: Center(child: Text('${m.groundName} • ${m.status}')),
                onTap: () => context.push('/match/${m.id}'),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
