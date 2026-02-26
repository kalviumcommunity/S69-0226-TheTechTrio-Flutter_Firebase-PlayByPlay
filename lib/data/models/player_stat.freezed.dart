// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_stat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerStat {
  String get id;
  String get matchId;
  String get teamId;
  String get playerName;
  int get stat1; // e.g., goals, runs
  int get stat2;

  /// Create a copy of PlayerStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlayerStatCopyWith<PlayerStat> get copyWith =>
      _$PlayerStatCopyWithImpl<PlayerStat>(this as PlayerStat, _$identity);

  /// Serializes this PlayerStat to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlayerStat &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.stat1, stat1) || other.stat1 == stat1) &&
            (identical(other.stat2, stat2) || other.stat2 == stat2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, matchId, teamId, playerName, stat1, stat2);

  @override
  String toString() {
    return 'PlayerStat(id: $id, matchId: $matchId, teamId: $teamId, playerName: $playerName, stat1: $stat1, stat2: $stat2)';
  }
}

/// @nodoc
abstract mixin class $PlayerStatCopyWith<$Res> {
  factory $PlayerStatCopyWith(
          PlayerStat value, $Res Function(PlayerStat) _then) =
      _$PlayerStatCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String matchId,
      String teamId,
      String playerName,
      int stat1,
      int stat2});
}

/// @nodoc
class _$PlayerStatCopyWithImpl<$Res> implements $PlayerStatCopyWith<$Res> {
  _$PlayerStatCopyWithImpl(this._self, this._then);

  final PlayerStat _self;
  final $Res Function(PlayerStat) _then;

  /// Create a copy of PlayerStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matchId = null,
    Object? teamId = null,
    Object? playerName = null,
    Object? stat1 = null,
    Object? stat2 = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      matchId: null == matchId
          ? _self.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _self.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _self.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      stat1: null == stat1
          ? _self.stat1
          : stat1 // ignore: cast_nullable_to_non_nullable
              as int,
      stat2: null == stat2
          ? _self.stat2
          : stat2 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PlayerStat].
extension PlayerStatPatterns on PlayerStat {
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
    TResult Function(_PlayerStat value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlayerStat() when $default != null:
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
    TResult Function(_PlayerStat value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlayerStat():
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
    TResult? Function(_PlayerStat value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlayerStat() when $default != null:
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
    TResult Function(String id, String matchId, String teamId,
            String playerName, int stat1, int stat2)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlayerStat() when $default != null:
        return $default(_that.id, _that.matchId, _that.teamId, _that.playerName,
            _that.stat1, _that.stat2);
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
    TResult Function(String id, String matchId, String teamId,
            String playerName, int stat1, int stat2)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlayerStat():
        return $default(_that.id, _that.matchId, _that.teamId, _that.playerName,
            _that.stat1, _that.stat2);
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
    TResult? Function(String id, String matchId, String teamId,
            String playerName, int stat1, int stat2)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlayerStat() when $default != null:
        return $default(_that.id, _that.matchId, _that.teamId, _that.playerName,
            _that.stat1, _that.stat2);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PlayerStat implements PlayerStat {
  const _PlayerStat(
      {required this.id,
      required this.matchId,
      required this.teamId,
      required this.playerName,
      this.stat1 = 0,
      this.stat2 = 0});
  factory _PlayerStat.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatFromJson(json);

  @override
  final String id;
  @override
  final String matchId;
  @override
  final String teamId;
  @override
  final String playerName;
  @override
  @JsonKey()
  final int stat1;
// e.g., goals, runs
  @override
  @JsonKey()
  final int stat2;

  /// Create a copy of PlayerStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlayerStatCopyWith<_PlayerStat> get copyWith =>
      __$PlayerStatCopyWithImpl<_PlayerStat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlayerStatToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlayerStat &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.stat1, stat1) || other.stat1 == stat1) &&
            (identical(other.stat2, stat2) || other.stat2 == stat2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, matchId, teamId, playerName, stat1, stat2);

  @override
  String toString() {
    return 'PlayerStat(id: $id, matchId: $matchId, teamId: $teamId, playerName: $playerName, stat1: $stat1, stat2: $stat2)';
  }
}

/// @nodoc
abstract mixin class _$PlayerStatCopyWith<$Res>
    implements $PlayerStatCopyWith<$Res> {
  factory _$PlayerStatCopyWith(
          _PlayerStat value, $Res Function(_PlayerStat) _then) =
      __$PlayerStatCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String matchId,
      String teamId,
      String playerName,
      int stat1,
      int stat2});
}

/// @nodoc
class __$PlayerStatCopyWithImpl<$Res> implements _$PlayerStatCopyWith<$Res> {
  __$PlayerStatCopyWithImpl(this._self, this._then);

  final _PlayerStat _self;
  final $Res Function(_PlayerStat) _then;

  /// Create a copy of PlayerStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? matchId = null,
    Object? teamId = null,
    Object? playerName = null,
    Object? stat1 = null,
    Object? stat2 = null,
  }) {
    return _then(_PlayerStat(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      matchId: null == matchId
          ? _self.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _self.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _self.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      stat1: null == stat1
          ? _self.stat1
          : stat1 // ignore: cast_nullable_to_non_nullable
              as int,
      stat2: null == stat2
          ? _self.stat2
          : stat2 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
