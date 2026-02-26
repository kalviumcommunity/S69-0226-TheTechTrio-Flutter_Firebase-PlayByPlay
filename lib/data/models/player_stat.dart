import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_stat.freezed.dart';
part 'player_stat.g.dart';

@freezed
abstract class PlayerStat with _$PlayerStat {
  const factory PlayerStat({
    required String id,
    required String matchId,
    required String teamId,
    required String playerName,
    @Default(0) int stat1, // e.g., goals, runs
    @Default(0) int stat2, // e.g., assists, wickets
  }) = _PlayerStat;

  factory PlayerStat.fromJson(Map<String, dynamic> json) => _$PlayerStatFromJson(json);
}
