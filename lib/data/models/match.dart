import 'package:cloud_firestore/cloud_firestore.dart';

class MatchScore {
  final int runs;
  final int wickets;
  final double overs; // Storing as double like 4.2

  MatchScore({
    required this.runs,
    required this.wickets,
    required this.overs,
  });

  factory MatchScore.fromMap(Map<String, dynamic> map) {
    return MatchScore(
      runs: map['runs'] ?? 0,
      wickets: map['wickets'] ?? 0,
      overs: (map['overs'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'runs': runs,
      'wickets': wickets,
      'overs': overs,
    };
  }
}

class MatchModel {
  final String id;
  final String tournamentId;
  final String teamAId;
  final String teamBId;
  final String venue;
  final DateTime? startTime;
  final String status;
  final int currentInnings;
  final MatchScore scoreA;
  final MatchScore scoreB;

  MatchModel({
    required this.id,
    required this.tournamentId,
    required this.teamAId,
    required this.teamBId,
    required this.venue,
    this.startTime,
    required this.status,
    required this.currentInnings,
    required this.scoreA,
    required this.scoreB,
  });

  factory MatchModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MatchModel(
      id: doc.id,
      tournamentId: data['tournamentId'] ?? '',
      teamAId: data['teamAId'] ?? '',
      teamBId: data['teamBId'] ?? '',
      venue: data['venue'] ?? '',
      startTime: (data['startTime'] as Timestamp?)?.toDate(),
      status: data['status'] ?? 'upcoming',
      currentInnings: data['currentInnings'] ?? 1,
      scoreA: MatchScore.fromMap(data['scoreA'] ?? {}),
      scoreB: MatchScore.fromMap(data['scoreB'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tournamentId': tournamentId,
      'teamAId': teamAId,
      'teamBId': teamBId,
      'venue': venue,
      'startTime': startTime != null ? Timestamp.fromDate(startTime!) : null,
      'status': status,
      'currentInnings': currentInnings,
      'scoreA': scoreA.toMap(),
      'scoreB': scoreB.toMap(),
    };
  }
}
