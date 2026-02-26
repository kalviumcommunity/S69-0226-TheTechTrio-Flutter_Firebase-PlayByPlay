import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbyplay/data/models/team.dart';

final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  return TeamRepository(FirebaseFirestore.instance);
});

class TeamRepository {
  final FirebaseFirestore _firestore;

  TeamRepository(this._firestore);

  CollectionReference get _teamsRef => _firestore.collection('teams');

  // Add a team to a tournament
  Future<void> createTeam(Team team) async {
    await _teamsRef.doc(team.id).set(team.toJson());
  }

  // Get all teams in a specific tournament
  Stream<List<Team>> streamTeamsForTournament(String tournamentId) {
    return _teamsRef
        .where('tournamentId', isEqualTo: tournamentId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Team.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
