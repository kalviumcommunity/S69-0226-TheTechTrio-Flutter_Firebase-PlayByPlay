import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbyplay/data/models/tournament.dart';

final tournamentRepositoryProvider = Provider<TournamentRepository>((ref) {
  return TournamentRepository(FirebaseFirestore.instance);
});

class TournamentRepository {
  final FirebaseFirestore _firestore;

  TournamentRepository(this._firestore);
  
  CollectionReference get _tournamentsRef => _firestore.collection('tournaments');

  Future<void> createTournament(Tournament tournament) async {
    await _tournamentsRef.doc(tournament.id).set(tournament.toJson());
  }

  // Stream all tournaments created by a specific user (for Organizer Dashboard)
  Stream<List<Tournament>> streamMyTournaments(String userId) {
    return _tournamentsRef
        .where('createdBy', isEqualTo: userId)
        .orderBy('startDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Tournament.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
