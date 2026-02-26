import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:playbyplay/data/models/match.dart';
import 'package:playbyplay/data/models/team.dart';
import 'package:playbyplay/data/models/player_stat.dart';

import 'package:playbyplay/data/repositories/match_repository.dart';
import 'package:playbyplay/data/repositories/team_repository.dart';


// Provides a stream of teams for a specific tournament
final tournamentTeamsProvider = StreamProvider.family.autoDispose<List<Team>, String>((ref, tournamentId) {
  return ref.watch(teamRepositoryProvider).streamTeamsForTournament(tournamentId);
});

// Provides a stream of matches for a specific tournament
final tournamentMatchesProvider = StreamProvider.family.autoDispose<List<MatchModel>, String>((ref, tournamentId) {
  return ref.watch(matchRepositoryProvider).streamMatchesForTournament(tournamentId);
});

// Provides a stream of matches for the Home Feed spectator view based on status
final matchesByStatusProvider = StreamProvider.family.autoDispose<List<MatchModel>, String>((ref, status) {
  return ref.watch(matchRepositoryProvider).streamMatchesByStatus(status);
});

// Streams a single match detail
final singleMatchProvider = StreamProvider.family.autoDispose<MatchModel, String>((ref, matchId) {
  return ref.watch(matchRepositoryProvider).streamMatch(matchId);
});

// Streams player stats for a single match
final matchStatsProvider = StreamProvider.family.autoDispose<List<PlayerStat>, String>((ref, matchId) {
  return ref.watch(matchRepositoryProvider).streamPlayerStats(matchId);
});

// UI Action Controller
final matchControllerProvider = Provider<MatchController>((ref) {
  return MatchController(ref.watch(matchRepositoryProvider), ref.watch(teamRepositoryProvider));
});

class MatchController {
  final MatchRepository _matchRepo;
  final TeamRepository _teamRepo;

  MatchController(this._matchRepo, this._teamRepo);

  Future<void> createTeam(Team team) => _teamRepo.createTeam(team);
  
  Future<void> createMatch(MatchModel match) => _matchRepo.createMatch(match);
  
  Future<void> updateStatus(String matchId, String status) => _matchRepo.updateMatchStatus(matchId, status);
  
  Future<void> updateScore(String matchId, int tA, int tB) => _matchRepo.updateScore(matchId, tA, tB);
  
  Future<void> addStat(PlayerStat stat) => _matchRepo.addPlayerStat(stat);
}
