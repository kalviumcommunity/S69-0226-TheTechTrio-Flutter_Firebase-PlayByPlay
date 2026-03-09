import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';
import '../models/match.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<EventModel>> getRecentEventsForMatch(String matchId, {int limit = 10}) {
    return _db
        .collection('events')
        .where('matchId', isEqualTo: matchId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EventModel.fromFirestore(doc))
            .toList());
  }

  /// Core Scoring Logic:
  /// Adds a new ball event and atomically updates the running match score.
  /// Automatically calculates the current over and ball relying on modulo 6 logic
  /// (6 balls = 1 over) based on the latest recorded event in the current innings.
  Future<void> addEventAndUpdateScore({
    required String matchId,
    required int runs,
    required bool isWicket,
    String? description,
  }) async {
    await _db.runTransaction((transaction) async {
      DocumentReference matchRef = _db.collection('matches').doc(matchId);
      DocumentSnapshot matchSnapshot = await transaction.get(matchRef);

      if (!matchSnapshot.exists) {
        throw Exception("Match not found!");
      }

      MatchModel match = MatchModel.fromFirestore(matchSnapshot);
      
      // Determine next ball details
      final eventsQuery = await _db
          .collection('events')
          .where('matchId', isEqualTo: matchId)
          .where('innings', isEqualTo: match.currentInnings)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      int overNumber = 0;
      int ballInOver = 1;

      if (eventsQuery.docs.isNotEmpty) {
        EventModel lastEvent = EventModel.fromFirestore(eventsQuery.docs.first);
        if (lastEvent.ballInOver == 6) {
          overNumber = lastEvent.overNumber + 1;
          ballInOver = 1;
        } else {
          overNumber = lastEvent.overNumber;
          ballInOver = lastEvent.ballInOver + 1;
        }
      }

      // Create new event document
      DocumentReference newEventRef = _db.collection('events').doc();
      EventModel newEvent = EventModel(
        id: newEventRef.id,
        matchId: matchId,
        innings: match.currentInnings,
        overNumber: overNumber,
        ballInOver: ballInOver,
        runs: runs,
        isWicket: isWicket,
        description: description,
        createdAt: DateTime.now(),
      );

      transaction.set(newEventRef, newEvent.toMap());

      // Update match score atomically
      Map<String, dynamic> updateData = {};
      double newOvers = double.parse('$overNumber.$ballInOver');
      
      if (match.currentInnings == 1) {
        updateData = {
          'scoreA.runs': match.scoreA.runs + runs,
          'scoreA.wickets': match.scoreA.wickets + (isWicket ? 1 : 0),
          'scoreA.overs': newOvers,
        };
      } else {
        updateData = {
          'scoreB.runs': match.scoreB.runs + runs,
          'scoreB.wickets': match.scoreB.wickets + (isWicket ? 1 : 0),
          'scoreB.overs': newOvers,
        };
      }

      transaction.update(matchRef, updateData);
    });
  }
}
