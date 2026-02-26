// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchModel {
  String get id;
  String get tournamentId;
  String get teamAId;
  String get teamBId;
  String get teamAName;
  String get teamBName;
  int get scoreTeamA;
  int get scoreTeamB;
  String get status;
  String get groundName;
  DateTime get startTime;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MatchModelCopyWith<MatchModel> get copyWith =>
      _$MatchModelCopyWithImpl<MatchModel>(this as MatchModel, _$identity);

  /// Serializes this MatchModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MatchModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.teamAId, teamAId) || other.teamAId == teamAId) &&
            (identical(other.teamBId, teamBId) || other.teamBId == teamBId) &&
            (identical(other.teamAName, teamAName) ||
                other.teamAName == teamAName) &&
            (identical(other.teamBName, teamBName) ||
                other.teamBName == teamBName) &&
            (identical(other.scoreTeamA, scoreTeamA) ||
                other.scoreTeamA == scoreTeamA) &&
            (identical(other.scoreTeamB, scoreTeamB) ||
                other.scoreTeamB == scoreTeamB) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.groundName, groundName) ||
                other.groundName == groundName) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tournamentId,
      teamAId,
      teamBId,
      teamAName,
      teamBName,
      scoreTeamA,
      scoreTeamB,
      status,
      groundName,
      startTime);

  @override
  String toString() {
    return 'MatchModel(id: $id, tournamentId: $tournamentId, teamAId: $teamAId, teamBId: $teamBId, teamAName: $teamAName, teamBName: $teamBName, scoreTeamA: $scoreTeamA, scoreTeamB: $scoreTeamB, status: $status, groundName: $groundName, startTime: $startTime)';
  }
}

/// @nodoc
abstract mixin class $MatchModelCopyWith<$Res> {
  factory $MatchModelCopyWith(
          MatchModel value, $Res Function(MatchModel) _then) =
      _$MatchModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String tournamentId,
      String teamAId,
      String teamBId,
      String teamAName,
      String teamBName,
      int scoreTeamA,
      int scoreTeamB,
      String status,
      String groundName,
      DateTime startTime});
}

/// @nodoc
class _$MatchModelCopyWithImpl<$Res> implements $MatchModelCopyWith<$Res> {
  _$MatchModelCopyWithImpl(this._self, this._then);

  final MatchModel _self;
  final $Res Function(MatchModel) _then;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tournamentId = null,
    Object? teamAId = null,
    Object? teamBId = null,
    Object? teamAName = null,
    Object? teamBName = null,
    Object? scoreTeamA = null,
    Object? scoreTeamB = null,
    Object? status = null,
    Object? groundName = null,
    Object? startTime = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentId: null == tournamentId
          ? _self.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      teamAId: null == teamAId
          ? _self.teamAId
          : teamAId // ignore: cast_nullable_to_non_nullable
              as String,
      teamBId: null == teamBId
          ? _self.teamBId
          : teamBId // ignore: cast_nullable_to_non_nullable
              as String,
      teamAName: null == teamAName
          ? _self.teamAName
          : teamAName // ignore: cast_nullable_to_non_nullable
              as String,
      teamBName: null == teamBName
          ? _self.teamBName
          : teamBName // ignore: cast_nullable_to_non_nullable
              as String,
      scoreTeamA: null == scoreTeamA
          ? _self.scoreTeamA
          : scoreTeamA // ignore: cast_nullable_to_non_nullable
              as int,
      scoreTeamB: null == scoreTeamB
          ? _self.scoreTeamB
          : scoreTeamB // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      groundName: null == groundName
          ? _self.groundName
          : groundName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [MatchModel].
extension MatchModelPatterns on MatchModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MatchModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MatchModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MatchModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MatchModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String tournamentId,
            String teamAId,
            String teamBId,
            String teamAName,
            String teamBName,
            int scoreTeamA,
            int scoreTeamB,
            String status,
            String groundName,
            DateTime startTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MatchModel() when $default != null:
        return $default(
            _that.id,
            _that.tournamentId,
            _that.teamAId,
            _that.teamBId,
            _that.teamAName,
            _that.teamBName,
            _that.scoreTeamA,
            _that.scoreTeamB,
            _that.status,
            _that.groundName,
            _that.startTime);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String tournamentId,
            String teamAId,
            String teamBId,
            String teamAName,
            String teamBName,
            int scoreTeamA,
            int scoreTeamB,
            String status,
            String groundName,
            DateTime startTime)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchModel():
        return $default(
            _that.id,
            _that.tournamentId,
            _that.teamAId,
            _that.teamBId,
            _that.teamAName,
            _that.teamBName,
            _that.scoreTeamA,
            _that.scoreTeamB,
            _that.status,
            _that.groundName,
            _that.startTime);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String tournamentId,
            String teamAId,
            String teamBId,
            String teamAName,
            String teamBName,
            int scoreTeamA,
            int scoreTeamB,
            String status,
            String groundName,
            DateTime startTime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchModel() when $default != null:
        return $default(
            _that.id,
            _that.tournamentId,
            _that.teamAId,
            _that.teamBId,
            _that.teamAName,
            _that.teamBName,
            _that.scoreTeamA,
            _that.scoreTeamB,
            _that.status,
            _that.groundName,
            _that.startTime);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MatchModel implements MatchModel {
  const _MatchModel(
      {required this.id,
      required this.tournamentId,
      required this.teamAId,
      required this.teamBId,
      required this.teamAName,
      required this.teamBName,
      required this.scoreTeamA,
      required this.scoreTeamB,
      required this.status,
      required this.groundName,
      required this.startTime});
  factory _MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);

  @override
  final String id;
  @override
  final String tournamentId;
  @override
  final String teamAId;
  @override
  final String teamBId;
  @override
  final String teamAName;
  @override
  final String teamBName;
  @override
  final int scoreTeamA;
  @override
  final int scoreTeamB;
  @override
  final String status;
  @override
  final String groundName;
  @override
  final DateTime startTime;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MatchModelCopyWith<_MatchModel> get copyWith =>
      __$MatchModelCopyWithImpl<_MatchModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MatchModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MatchModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.teamAId, teamAId) || other.teamAId == teamAId) &&
            (identical(other.teamBId, teamBId) || other.teamBId == teamBId) &&
            (identical(other.teamAName, teamAName) ||
                other.teamAName == teamAName) &&
            (identical(other.teamBName, teamBName) ||
                other.teamBName == teamBName) &&
            (identical(other.scoreTeamA, scoreTeamA) ||
                other.scoreTeamA == scoreTeamA) &&
            (identical(other.scoreTeamB, scoreTeamB) ||
                other.scoreTeamB == scoreTeamB) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.groundName, groundName) ||
                other.groundName == groundName) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tournamentId,
      teamAId,
      teamBId,
      teamAName,
      teamBName,
      scoreTeamA,
      scoreTeamB,
      status,
      groundName,
      startTime);

  @override
  String toString() {
    return 'MatchModel(id: $id, tournamentId: $tournamentId, teamAId: $teamAId, teamBId: $teamBId, teamAName: $teamAName, teamBName: $teamBName, scoreTeamA: $scoreTeamA, scoreTeamB: $scoreTeamB, status: $status, groundName: $groundName, startTime: $startTime)';
  }
}

/// @nodoc
abstract mixin class _$MatchModelCopyWith<$Res>
    implements $MatchModelCopyWith<$Res> {
  factory _$MatchModelCopyWith(
          _MatchModel value, $Res Function(_MatchModel) _then) =
      __$MatchModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String tournamentId,
      String teamAId,
      String teamBId,
      String teamAName,
      String teamBName,
      int scoreTeamA,
      int scoreTeamB,
      String status,
      String groundName,
      DateTime startTime});
}

/// @nodoc
class __$MatchModelCopyWithImpl<$Res> implements _$MatchModelCopyWith<$Res> {
  __$MatchModelCopyWithImpl(this._self, this._then);

  final _MatchModel _self;
  final $Res Function(_MatchModel) _then;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? tournamentId = null,
    Object? teamAId = null,
    Object? teamBId = null,
    Object? teamAName = null,
    Object? teamBName = null,
    Object? scoreTeamA = null,
    Object? scoreTeamB = null,
    Object? status = null,
    Object? groundName = null,
    Object? startTime = null,
  }) {
    return _then(_MatchModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentId: null == tournamentId
          ? _self.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      teamAId: null == teamAId
          ? _self.teamAId
          : teamAId // ignore: cast_nullable_to_non_nullable
              as String,
      teamBId: null == teamBId
          ? _self.teamBId
          : teamBId // ignore: cast_nullable_to_non_nullable
              as String,
      teamAName: null == teamAName
          ? _self.teamAName
          : teamAName // ignore: cast_nullable_to_non_nullable
              as String,
      teamBName: null == teamBName
          ? _self.teamBName
          : teamBName // ignore: cast_nullable_to_non_nullable
              as String,
      scoreTeamA: null == scoreTeamA
          ? _self.scoreTeamA
          : scoreTeamA // ignore: cast_nullable_to_non_nullable
              as int,
      scoreTeamB: null == scoreTeamB
          ? _self.scoreTeamB
          : scoreTeamB // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      groundName: null == groundName
          ? _self.groundName
          : groundName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
