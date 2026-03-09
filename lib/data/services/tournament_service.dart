import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/tournament.dart';

class TournamentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<TournamentModel?> getCurrentTournament() async {
    try {
      final snapshot = await _db
          .collection('tournaments')
          .where('isCurrent', isEqualTo: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return TournamentModel.fromFirestore(snapshot.docs.first);
      }
    } catch (e) {
      debugPrint('Error fetching current tournament: $e');
    }
    return null;
  }
}
