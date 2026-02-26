// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tournament {
  String get id;
  String get name;
  String get sport;
  String get location;
  DateTime get startDate;
  DateTime get endDate;
  String get createdBy;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TournamentCopyWith<Tournament> get copyWith =>
      _$TournamentCopyWithImpl<Tournament>(this as Tournament, _$identity);

  /// Serializes this Tournament to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Tournament &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sport, sport) || other.sport == sport) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, sport, location, startDate, endDate, createdBy);

  @override
  String toString() {
    return 'Tournament(id: $id, name: $name, sport: $sport, location: $location, startDate: $startDate, endDate: $endDate, createdBy: $createdBy)';
  }
}

/// @nodoc
abstract mixin class $TournamentCopyWith<$Res> {
  factory $TournamentCopyWith(
          Tournament value, $Res Function(Tournament) _then) =
      _$TournamentCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String sport,
      String location,
      DateTime startDate,
      DateTime endDate,
      String createdBy});
}

/// @nodoc
class _$TournamentCopyWithImpl<$Res> implements $TournamentCopyWith<$Res> {
  _$TournamentCopyWithImpl(this._self, this._then);

  final Tournament _self;
  final $Res Function(Tournament) _then;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sport = null,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? createdBy = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sport: null == sport
          ? _self.sport
          : sport // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Tournament].
extension TournamentPatterns on Tournament {
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
    TResult Function(_Tournament value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Tournament() when $default != null:
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
    TResult Function(_Tournament value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Tournament():
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
    TResult? Function(_Tournament value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Tournament() when $default != null:
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
    TResult Function(String id, String name, String sport, String location,
            DateTime startDate, DateTime endDate, String createdBy)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Tournament() when $default != null:
        return $default(_that.id, _that.name, _that.sport, _that.location,
            _that.startDate, _that.endDate, _that.createdBy);
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
    TResult Function(String id, String name, String sport, String location,
            DateTime startDate, DateTime endDate, String createdBy)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Tournament():
        return $default(_that.id, _that.name, _that.sport, _that.location,
            _that.startDate, _that.endDate, _that.createdBy);
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
    TResult? Function(String id, String name, String sport, String location,
            DateTime startDate, DateTime endDate, String createdBy)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Tournament() when $default != null:
        return $default(_that.id, _that.name, _that.sport, _that.location,
            _that.startDate, _that.endDate, _that.createdBy);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Tournament implements Tournament {
  const _Tournament(
      {required this.id,
      required this.name,
      required this.sport,
      required this.location,
      required this.startDate,
      required this.endDate,
      required this.createdBy});
  factory _Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String sport;
  @override
  final String location;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String createdBy;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TournamentCopyWith<_Tournament> get copyWith =>
      __$TournamentCopyWithImpl<_Tournament>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TournamentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Tournament &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sport, sport) || other.sport == sport) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, sport, location, startDate, endDate, createdBy);

  @override
  String toString() {
    return 'Tournament(id: $id, name: $name, sport: $sport, location: $location, startDate: $startDate, endDate: $endDate, createdBy: $createdBy)';
  }
}

/// @nodoc
abstract mixin class _$TournamentCopyWith<$Res>
    implements $TournamentCopyWith<$Res> {
  factory _$TournamentCopyWith(
          _Tournament value, $Res Function(_Tournament) _then) =
      __$TournamentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String sport,
      String location,
      DateTime startDate,
      DateTime endDate,
      String createdBy});
}

/// @nodoc
class __$TournamentCopyWithImpl<$Res> implements _$TournamentCopyWith<$Res> {
  __$TournamentCopyWithImpl(this._self, this._then);

  final _Tournament _self;
  final $Res Function(_Tournament) _then;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sport = null,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? createdBy = null,
  }) {
    return _then(_Tournament(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sport: null == sport
          ? _self.sport
          : sport // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
