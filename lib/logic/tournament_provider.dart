import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbyplay/data/models/tournament.dart';
import 'package:playbyplay/data/repositories/tournament_repository.dart';
import 'auth_provider.dart';

// Stream of tournaments created by the currently logged-in Organizer
final myTournamentsProvider = StreamProvider.autoDispose<List<Tournament>>((ref) {
  final uid = ref.watch(authStateProvider).value;
  if (uid == null) return const Stream.empty();
  
  return ref.watch(tournamentRepositoryProvider).streamMyTournaments(uid);
});

// Provides a way for UI to trigger tournament creation
final tournamentControllerProvider = Provider<TournamentController>((ref) {
  return TournamentController(ref.watch(tournamentRepositoryProvider));
});

class TournamentController {
  final TournamentRepository _repo;
  TournamentController(this._repo);

  Future<void> create(Tournament tournament) async {
    await _repo.createTournament(tournament);
  }
}
