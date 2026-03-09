import 'package:cloud_firestore/cloud_firestore.dart';

class TeamModel {
  final String id;
  final String tournamentId;
  final String name;
  final String shortName;

  TeamModel({
    required this.id,
    required this.tournamentId,
    required this.name,
    required this.shortName,
  });

  factory TeamModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TeamModel(
      id: doc.id,
      tournamentId: data['tournamentId'] ?? '',
      name: data['name'] ?? '',
      shortName: data['shortName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tournamentId': tournamentId,
      'name': name,
      'shortName': shortName,
    };
  }
}
