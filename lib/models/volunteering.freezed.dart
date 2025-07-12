// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'volunteering.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Volunteering {
  String get id;
  String get name;
  String get type;
  int get vacancies;
  LatLng get location;
  String get imageUrl;
  String get description;
  String get summary;
  String get requirements;
  double get cost;
  DateTime get createdAt;

  /// Create a copy of Volunteering
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VolunteeringCopyWith<Volunteering> get copyWith =>
      _$VolunteeringCopyWithImpl<Volunteering>(
          this as Volunteering, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Volunteering &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.vacancies, vacancies) ||
                other.vacancies == vacancies) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.requirements, requirements) ||
                other.requirements == requirements) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, vacancies,
      location, imageUrl, description, summary, requirements, cost, createdAt);

  @override
  String toString() {
    return 'Volunteering(id: $id, name: $name, type: $type, vacancies: $vacancies, location: $location, imageUrl: $imageUrl, description: $description, summary: $summary, requirements: $requirements, cost: $cost, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $VolunteeringCopyWith<$Res> {
  factory $VolunteeringCopyWith(
          Volunteering value, $Res Function(Volunteering) _then) =
      _$VolunteeringCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      int vacancies,
      LatLng location,
      String imageUrl,
      String description,
      String summary,
      String requirements,
      double cost,
      DateTime createdAt});
}

/// @nodoc
class _$VolunteeringCopyWithImpl<$Res> implements $VolunteeringCopyWith<$Res> {
  _$VolunteeringCopyWithImpl(this._self, this._then);

  final Volunteering _self;
  final $Res Function(Volunteering) _then;

  /// Create a copy of Volunteering
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? vacancies = null,
    Object? location = null,
    Object? imageUrl = null,
    Object? description = null,
    Object? summary = null,
    Object? requirements = null,
    Object? cost = null,
    Object? createdAt = null,
  }) {
    return _then(Volunteering(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      vacancies: null == vacancies
          ? _self.vacancies
          : vacancies // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      requirements: null == requirements
          ? _self.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _self.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
