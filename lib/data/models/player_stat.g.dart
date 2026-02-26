// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerStat _$PlayerStatFromJson(Map<String, dynamic> json) => _PlayerStat(
      id: json['id'] as String,
      matchId: json['matchId'] as String,
      teamId: json['teamId'] as String,
      playerName: json['playerName'] as String,
      stat1: (json['stat1'] as num?)?.toInt() ?? 0,
      stat2: (json['stat2'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PlayerStatToJson(_PlayerStat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'matchId': instance.matchId,
      'teamId': instance.teamId,
      'playerName': instance.playerName,
      'stat1': instance.stat1,
      'stat2': instance.stat2,
    };
