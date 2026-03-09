import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/match.dart';
import '../models/event.dart';
import '../models/team.dart';
import '../models/tournament.dart';
import '../models/stats.dart';

class StatsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Generate Points Table for the current active tournament.
  /// Points Table Rules (MVP):
  /// - Only consider matches with status == "finished".
  /// - Team with higher total runs wins.
  /// - 2 points for win, 0 for loss.
  Future<List<TeamStats>> getPointsTableForCurrentTournament() async {
    try {
      // 1. Fetch current tournament
      final tournamentSnapshot = await _db
          .collection('tournaments')
          .where('isCurrent', isEqualTo: true)
          .limit(1)
          .get();

      if (tournamentSnapshot.docs.isEmpty) {
        return [];
      }

      final tournament = TournamentModel.fromFirestore(tournamentSnapshot.docs.first);

      // 2. Fetch teams for this tournament
      final teamsSnapshot = await _db
          .collection('teams')
          .where('tournamentId', isEqualTo: tournament.id)
          .get();

      final teamsMap = <String, TeamModel>{};
      final statsMap = <String, TeamStats>{};

      for (var doc in teamsSnapshot.docs) {
        final team = TeamModel.fromFirestore(doc);
        teamsMap[team.id] = team;
        statsMap[team.id] = TeamStats(teamId: team.id, teamName: team.name);
      }

      // 3. Fetch finished matches for this tournament
      final matchesSnapshot = await _db
          .collection('matches')
          .where('tournamentId', isEqualTo: tournament.id)
          .where('status', isEqualTo: 'finished')
          .get();

      // 4. Compute matchesPlayed, wins, losses, points
      for (var doc in matchesSnapshot.docs) {
        final match = MatchModel.fromFirestore(doc);

        final teamAId = match.teamAId;
        final teamBId = match.teamBId;

        // Ensure teams exist in our map
        if (!statsMap.containsKey(teamAId) && teamsMap.containsKey(teamAId)) {
          statsMap[teamAId] = TeamStats(teamId: teamAId, teamName: teamsMap[teamAId]!.name);
        }
        if (!statsMap.containsKey(teamBId) && teamsMap.containsKey(teamBId)) {
          statsMap[teamBId] = TeamStats(teamId: teamBId, teamName: teamsMap[teamBId]!.name);
        }

        final scoreA = match.scoreA.runs;
        final scoreB = match.scoreB.runs;

        String? winnerId;
        String? loserId;

        if (scoreA > scoreB) {
          winnerId = teamAId;
          loserId = teamBId;
        } else if (scoreB > scoreA) {
          winnerId = teamBId;
          loserId = teamAId;
        }

        if (winnerId != null && statsMap.containsKey(winnerId)) {
          final s = statsMap[winnerId]!;
          statsMap[winnerId] = TeamStats(
            teamId: s.teamId,
            teamName: s.teamName,
            matchesPlayed: s.matchesPlayed + 1,
            wins: s.wins + 1,
            losses: s.losses,
            points: s.points + 2,
          );
        }

        if (loserId != null && statsMap.containsKey(loserId)) {
          final s = statsMap[loserId]!;
          statsMap[loserId] = TeamStats(
            teamId: s.teamId,
            teamName: s.teamName,
            matchesPlayed: s.matchesPlayed + 1,
            wins: s.wins,
            losses: s.losses + 1,
            points: s.points,
          );
        }
      }

      // 5. Convert to list and sort
      final List<TeamStats> pointsTable = statsMap.values.toList();
      pointsTable.sort((a, b) => b.points.compareTo(a.points)); // Sort descending by points

      return pointsTable;
    } catch (e) {
      debugPrint('Error computing points table: $e');
      return [];
    }
  }

  /// Generate Top Run Scorers based on batting events for the current tournament.
  /// Top Scorers Rules (MVP):
  /// - Only events with a non-null batsmanId are considered.
  Future<List<PlayerBattingStats>> getTopRunScorersForCurrentTournament({int limit = 5}) async {
    try {
      // 1. Fetch current tournament
      final tournamentSnapshot = await _db
          .collection('tournaments')
          .where('isCurrent', isEqualTo: true)
          .limit(1)
          .get();

      if (tournamentSnapshot.docs.isEmpty) {
        return [];
      }

      final tournament = TournamentModel.fromFirestore(tournamentSnapshot.docs.first);

      // 2. Fetch matches for this tournament
      final matchesSnapshot = await _db
          .collection('matches')
          .where('tournamentId', isEqualTo: tournament.id)
          .get();

      if (matchesSnapshot.docs.isEmpty) return [];

      final matchIds = matchesSnapshot.docs.map((doc) => doc.id).toList();

      // Firestore limits 'in' queries to 10 items, but 'whereIn' is convenient if less than 10.
      // Easiest robust approach for large tournaments: fetch events in chunks or simply loop matches.
      // For MVP, we'll fetch events per match since matches are finite.
      final battingStatsMap = <String, PlayerBattingStats>{};

      for (var matchId in matchIds) {
        final eventsSnapshot = await _db
            .collection('events')
            .where('matchId', isEqualTo: matchId)
            // Can't filter by clear batsmanId != null natively easily with other queries, do it in memory
            .get();

        for (var doc in eventsSnapshot.docs) {
          final event = EventModel.fromFirestore(doc);

          if (event.batsmanId != null && event.batsmanId!.isNotEmpty) {
            final playerId = event.batsmanId!;
            final currentStats = battingStatsMap[playerId] ??
                PlayerBattingStats(
                  playerId: playerId,
                  playerName: event.batsmanName,
                );

            battingStatsMap[playerId] = PlayerBattingStats(
              playerId: playerId,
              playerName: event.batsmanName ?? currentStats.playerName,
              totalRuns: currentStats.totalRuns + event.runs,
              ballsFaced: currentStats.ballsFaced + 1,
            );
          }
        }
      }

      final List<PlayerBattingStats> topScorers = battingStatsMap.values.toList();
      topScorers.sort((a, b) => b.totalRuns.compareTo(a.totalRuns));

      if (topScorers.length > limit) {
        return topScorers.sublist(0, limit);
      }
      return topScorers;
    } catch (e) {
      debugPrint('Error computing top scorers: $e');
      return [];
    }
  }
}
