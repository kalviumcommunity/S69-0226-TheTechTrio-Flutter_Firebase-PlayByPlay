import 'package:cloud_firestore/cloud_firestore.dart';

class TournamentModel {
  final String id;
  final String name;
  final String location;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrent;

  TournamentModel({
    required this.id,
    required this.name,
    required this.location,
    this.startDate,
    this.endDate,
    required this.isCurrent,
  });

  factory TournamentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TournamentModel(
      id: doc.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      startDate: (data['startDate'] as Timestamp?)?.toDate(),
      endDate: (data['endDate'] as Timestamp?)?.toDate(),
      isCurrent: data['isCurrent'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'startDate': startDate != null ? Timestamp.fromDate(startDate!) : null,
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'isCurrent': isCurrent,
    };
  }
}
