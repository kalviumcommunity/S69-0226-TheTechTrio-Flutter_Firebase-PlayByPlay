import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/match.dart';

class MatchService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<MatchModel>> getMatchesForTournament(String tournamentId) {
    return _db
        .collection('matches')
        .where('tournamentId', isEqualTo: tournamentId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MatchModel.fromFirestore(doc))
            .toList());
  }

  Stream<MatchModel?> getMatchById(String matchId) {
    return _db
        .collection('matches')
        .doc(matchId)
        .snapshots()
        .map((doc) => doc.exists ? MatchModel.fromFirestore(doc) : null);
  }
}
