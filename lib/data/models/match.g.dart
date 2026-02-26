// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => _MatchModel(
      id: json['id'] as String,
      tournamentId: json['tournamentId'] as String,
      teamAId: json['teamAId'] as String,
      teamBId: json['teamBId'] as String,
      teamAName: json['teamAName'] as String,
      teamBName: json['teamBName'] as String,
      scoreTeamA: (json['scoreTeamA'] as num).toInt(),
      scoreTeamB: (json['scoreTeamB'] as num).toInt(),
      status: json['status'] as String,
      groundName: json['groundName'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
    );

Map<String, dynamic> _$MatchModelToJson(_MatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tournamentId': instance.tournamentId,
      'teamAId': instance.teamAId,
      'teamBId': instance.teamBId,
      'teamAName': instance.teamAName,
      'teamBName': instance.teamBName,
      'scoreTeamA': instance.scoreTeamA,
      'scoreTeamB': instance.scoreTeamB,
      'status': instance.status,
      'groundName': instance.groundName,
      'startTime': instance.startTime.toIso8601String(),
    };
