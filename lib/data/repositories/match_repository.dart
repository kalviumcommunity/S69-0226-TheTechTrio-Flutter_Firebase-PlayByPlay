import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbyplay/data/models/match.dart';
import 'package:playbyplay/data/models/player_stat.dart';

final matchRepositoryProvider = Provider<MatchRepository>((ref) {
  return MatchRepository(FirebaseFirestore.instance);
});

class MatchRepository {
  final FirebaseFirestore _firestore;

  MatchRepository(this._firestore);

  CollectionReference get _matchesRef => _firestore.collection('matches');

  Future<void> createMatch(MatchModel match) async {
    await _matchesRef.doc(match.id).set(match.toJson());
  }

  // Update a match's status or score
  Future<void> updateMatchStatus(String matchId, String newStatus) async {
    await _matchesRef.doc(matchId).update({'status': newStatus});
  }

  Future<void> updateScore(String matchId, int teamAScore, int teamBScore) async {
    await _matchesRef.doc(matchId).update({
      'scoreTeamA': teamAScore,
      'scoreTeamB': teamBScore,
    });
  }

  // Real-time stream for a single match
  Stream<MatchModel> streamMatch(String matchId) {
    return _matchesRef.doc(matchId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) throw Exception('Match not found');
      return MatchModel.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  // Matches for a particular tournament
  Stream<List<MatchModel>> streamMatchesForTournament(String tournamentId) {
    return _matchesRef
        .where('tournamentId', isEqualTo: tournamentId)
        .orderBy('startTime')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MatchModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Spectator Feed: View all matches by status (Live, NOT_STARTED, FINISHED)
  Stream<List<MatchModel>> streamMatchesByStatus(String status) {
    return _matchesRef
        .where('status', isEqualTo: status)
        .orderBy('startTime', descending: status == 'LIVE') // order live matches oldest first, others by start
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MatchModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // --- PlayerStats Subcollection Methods ---
  
  Future<void> addPlayerStat(PlayerStat stat) async {
    final rootMatchRef = _matchesRef.doc(stat.matchId);
    await rootMatchRef.collection('playerStats').doc(stat.id).set(stat.toJson());
  }

  Stream<List<PlayerStat>> streamPlayerStats(String matchId) {
    return _matchesRef
        .doc(matchId)
        .collection('playerStats')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PlayerStat.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
