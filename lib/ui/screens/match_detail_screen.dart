import 'package:flutter/material.dart';
import '../../data/models/match.dart' as app_models;
import '../../data/models/event.dart';
import '../../data/services/match_service.dart';
import '../../data/services/event_service.dart';

class MatchDetailScreen extends StatelessWidget {
  final String matchId;

  const MatchDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    final MatchService matchService = MatchService();
    final EventService eventService = EventService();

    return StreamBuilder<app_models.MatchModel?>(
      stream: matchService.getMatchById(matchId),
      builder: (context, matchSnapshot) {
        if (matchSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (matchSnapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${matchSnapshot.error}')));
        }

        final match = matchSnapshot.data;
        if (match == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Match Details')),
            body: const Center(child: Text('Match not found.')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('${match.teamAId} vs ${match.teamBId}'),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          body: Column(
            children: [
              _buildMatchHeader(context, match),
              _buildScorecard(context, match),
              const Divider(thickness: 4),
              Expanded(
                child: _buildRecentEventsList(eventService),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMatchHeader(BuildContext context, app_models.MatchModel match) {
    Color statusColor = Colors.grey;
    if (match.status == 'live') statusColor = Colors.red;
    if (match.status == 'finished') statusColor = Colors.green;

    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.stadium, size: 16),
              const SizedBox(width: 4),
              Text(match.venue),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              match.status.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScorecard(BuildContext context, app_models.MatchModel match) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTeamScore(context, match.teamAId, match.scoreA, match.currentInnings == 1),
          const Text('VS', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          _buildTeamScore(context, match.teamBId, match.scoreB, match.currentInnings == 2),
        ],
      ),
    );
  }

  Widget _buildTeamScore(BuildContext context, String teamName, app_models.MatchScore score, bool isBatting) {
    return Column(
      children: [
        Text(
          teamName.isNotEmpty ? teamName : 'Team',
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold,
            color: isBatting ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${score.runs}/${score.wickets}',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(
          '(${score.overs} ov)',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        if (isBatting) 
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.sports_cricket, size: 16, color: Colors.redAccent),
          )
      ],
    );
  }

  Widget _buildRecentEventsList(EventService eventService) {
    return StreamBuilder<List<EventModel>>(
      stream: eventService.getRecentEventsForMatch(matchId, limit: 20),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final events = snapshot.data ?? [];

        if (events.isEmpty) {
          return const Center(child: Text('No events recorded yet.'));
        }

        return ListView.separated(
          itemCount: events.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final event = events[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: event.isWicket ? Colors.red.shade100 : Colors.blue.shade50,
                child: Text(
                  event.isWicket ? 'W' : '${event.runs}',
                  style: TextStyle(
                    color: event.isWicket ? Colors.red : Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text('Over ${event.overNumber}.${event.ballInOver}'),
              subtitle: event.description != null && event.description!.isNotEmpty 
                  ? Text(event.description!) 
                  : null,
            );
          },
        );
      },
    );
  }
}
