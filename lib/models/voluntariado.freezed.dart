// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voluntariado.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Voluntariado _$VoluntariadoFromJson(Map<String, dynamic> json) {
  return _Voluntariado.fromJson(json);
}

/// @nodoc
mixin _$Voluntariado {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'nombre')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'tipo')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'vacantes')
  int get vacancies => throw _privateConstructorUsedError;
  @GeoPointConverter()
  @JsonKey(name: 'location')
  LatLng get location => throw _privateConstructorUsedError;
  @TrimConverter()
  @JsonKey(name: 'imageUrl')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'descripcion')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'resumen')
  String get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'requisitos')
  String get requirements => throw _privateConstructorUsedError;
  @JsonKey(name: 'costo')
  double get cost => throw _privateConstructorUsedError;
  @TimestampConverter()
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Voluntariado to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Voluntariado
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoluntariadoCopyWith<Voluntariado> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoluntariadoCopyWith<$Res> {
  factory $VoluntariadoCopyWith(
          Voluntariado value, $Res Function(Voluntariado) then) =
      _$VoluntariadoCopyWithImpl<$Res, Voluntariado>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'nombre') String name,
      @JsonKey(name: 'tipo') String type,
      @JsonKey(name: 'vacantes') int vacancies,
      @GeoPointConverter() @JsonKey(name: 'location') LatLng location,
      @TrimConverter() @JsonKey(name: 'imageUrl') String imageUrl,
      @JsonKey(name: 'descripcion') String description,
      @JsonKey(name: 'resumen') String summary,
      @JsonKey(name: 'requisitos') String requirements,
      @JsonKey(name: 'costo') double cost,
      @TimestampConverter() @JsonKey(name: 'createdAt') DateTime createdAt});
}

/// @nodoc
class _$VoluntariadoCopyWithImpl<$Res, $Val extends Voluntariado>
    implements $VoluntariadoCopyWith<$Res> {
  _$VoluntariadoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Voluntariado
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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      vacancies: null == vacancies
          ? _value.vacancies
          : vacancies // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      requirements: null == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoluntariadoImplCopyWith<$Res>
    implements $VoluntariadoCopyWith<$Res> {
  factory _$$VoluntariadoImplCopyWith(
          _$VoluntariadoImpl value, $Res Function(_$VoluntariadoImpl) then) =
      __$$VoluntariadoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'nombre') String name,
      @JsonKey(name: 'tipo') String type,
      @JsonKey(name: 'vacantes') int vacancies,
      @GeoPointConverter() @JsonKey(name: 'location') LatLng location,
      @TrimConverter() @JsonKey(name: 'imageUrl') String imageUrl,
      @JsonKey(name: 'descripcion') String description,
      @JsonKey(name: 'resumen') String summary,
      @JsonKey(name: 'requisitos') String requirements,
      @JsonKey(name: 'costo') double cost,
      @TimestampConverter() @JsonKey(name: 'createdAt') DateTime createdAt});
}

/// @nodoc
class __$$VoluntariadoImplCopyWithImpl<$Res>
    extends _$VoluntariadoCopyWithImpl<$Res, _$VoluntariadoImpl>
    implements _$$VoluntariadoImplCopyWith<$Res> {
  __$$VoluntariadoImplCopyWithImpl(
      _$VoluntariadoImpl _value, $Res Function(_$VoluntariadoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Voluntariado
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
    return _then(_$VoluntariadoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      vacancies: null == vacancies
          ? _value.vacancies
          : vacancies // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      requirements: null == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoluntariadoImpl extends _Voluntariado {
  const _$VoluntariadoImpl(
      {required this.id,
      @JsonKey(name: 'nombre') required this.name,
      @JsonKey(name: 'tipo') required this.type,
      @JsonKey(name: 'vacantes') required this.vacancies,
      @GeoPointConverter() @JsonKey(name: 'location') required this.location,
      @TrimConverter() @JsonKey(name: 'imageUrl') required this.imageUrl,
      @JsonKey(name: 'descripcion') required this.description,
      @JsonKey(name: 'resumen') required this.summary,
      @JsonKey(name: 'requisitos') required this.requirements,
      @JsonKey(name: 'costo') required this.cost,
      @TimestampConverter()
      @JsonKey(name: 'createdAt')
      required this.createdAt})
      : super._();

  factory _$VoluntariadoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoluntariadoImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'nombre')
  final String name;
  @override
  @JsonKey(name: 'tipo')
  final String type;
  @override
  @JsonKey(name: 'vacantes')
  final int vacancies;
  @override
  @GeoPointConverter()
  @JsonKey(name: 'location')
  final LatLng location;
  @override
  @TrimConverter()
  @JsonKey(name: 'imageUrl')
  final String imageUrl;
  @override
  @JsonKey(name: 'descripcion')
  final String description;
  @override
  @JsonKey(name: 'resumen')
  final String summary;
  @override
  @JsonKey(name: 'requisitos')
  final String requirements;
  @override
  @JsonKey(name: 'costo')
  final double cost;
  @override
  @TimestampConverter()
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  String toString() {
    return 'Voluntariado(id: $id, name: $name, type: $type, vacancies: $vacancies, location: $location, imageUrl: $imageUrl, description: $description, summary: $summary, requirements: $requirements, cost: $cost, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoluntariadoImpl &&
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

  /// Create a copy of Voluntariado
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoluntariadoImplCopyWith<_$VoluntariadoImpl> get copyWith =>
      __$$VoluntariadoImplCopyWithImpl<_$VoluntariadoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoluntariadoImplToJson(
      this,
    );
  }
}

abstract class _Voluntariado extends Voluntariado {
  const factory _Voluntariado(
      {required final String id,
      @JsonKey(name: 'nombre') required final String name,
      @JsonKey(name: 'tipo') required final String type,
      @JsonKey(name: 'vacantes') required final int vacancies,
      @GeoPointConverter()
      @JsonKey(name: 'location')
      required final LatLng location,
      @TrimConverter()
      @JsonKey(name: 'imageUrl')
      required final String imageUrl,
      @JsonKey(name: 'descripcion') required final String description,
      @JsonKey(name: 'resumen') required final String summary,
      @JsonKey(name: 'requisitos') required final String requirements,
      @JsonKey(name: 'costo') required final double cost,
      @TimestampConverter()
      @JsonKey(name: 'createdAt')
      required final DateTime createdAt}) = _$VoluntariadoImpl;
  const _Voluntariado._() : super._();

  factory _Voluntariado.fromJson(Map<String, dynamic> json) =
      _$VoluntariadoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'nombre')
  String get name;
  @override
  @JsonKey(name: 'tipo')
  String get type;
  @override
  @JsonKey(name: 'vacantes')
  int get vacancies;
  @override
  @GeoPointConverter()
  @JsonKey(name: 'location')
  LatLng get location;
  @override
  @TrimConverter()
  @JsonKey(name: 'imageUrl')
  String get imageUrl;
  @override
  @JsonKey(name: 'descripcion')
  String get description;
  @override
  @JsonKey(name: 'resumen')
  String get summary;
  @override
  @JsonKey(name: 'requisitos')
  String get requirements;
  @override
  @JsonKey(name: 'costo')
  double get cost;
  @override
  @TimestampConverter()
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;

  /// Create a copy of Voluntariado
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoluntariadoImplCopyWith<_$VoluntariadoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
