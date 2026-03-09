import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String matchId;
  final int innings;
  final int overNumber;
  final int ballInOver;
  final int runs;
  final bool isWicket;
  final String? description;
  final DateTime createdAt;

  EventModel({
    required this.id,
    required this.matchId,
    required this.innings,
    required this.overNumber,
    required this.ballInOver,
    required this.runs,
    required this.isWicket,
    this.description,
    required this.createdAt,
  });

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return EventModel(
      id: doc.id,
      matchId: data['matchId'] ?? '',
      innings: data['innings'] ?? 1,
      overNumber: data['overNumber'] ?? 0,
      ballInOver: data['ballInOver'] ?? 0,
      runs: data['runs'] ?? 0,
      isWicket: data['isWicket'] ?? false,
      description: data['description'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'matchId': matchId,
      'innings': innings,
      'overNumber': overNumber,
      'ballInOver': ballInOver,
      'runs': runs,
      'isWicket': isWicket,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
