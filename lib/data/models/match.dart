import 'package:freezed_annotation/freezed_annotation.dart';

part 'match.freezed.dart';
part 'match.g.dart';

@freezed
abstract class MatchModel with _$MatchModel {
  const factory MatchModel({
    required String id,
    required String tournamentId,
    required String teamAId,
    required String teamBId,
    required String teamAName,
    required String teamBName,
    required int scoreTeamA,
    required int scoreTeamB,
    required String status,
    required String groundName,
    required DateTime startTime,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);
}
