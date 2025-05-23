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
  String get nombre => throw _privateConstructorUsedError;
  String get tipo => throw _privateConstructorUsedError;
  int get vacantes =>
      throw _privateConstructorUsedError; // required bool isLiked, // TODO, esto depende del usuario, no? No deberia estar dentro de la clase User?
  @GeoPointConverter()
  LatLng get location =>
      throw _privateConstructorUsedError; //    required VoluntariadoStatus estado, // TODO, esto depende del usuario, no? No deberia estar dentro de la clase User?
  String get imageUrl => throw _privateConstructorUsedError;
  String get descripcion => throw _privateConstructorUsedError;
  String get resumen => throw _privateConstructorUsedError;
  List<String> get requisitos => throw _privateConstructorUsedError;
  List<String> get disponibilidad =>
      throw _privateConstructorUsedError; // TODO que deje de ser string?
  String? get notas => throw _privateConstructorUsedError;

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
      String nombre,
      String tipo,
      int vacantes,
      @GeoPointConverter() LatLng location,
      String imageUrl,
      String descripcion,
      String resumen,
      List<String> requisitos,
      List<String> disponibilidad,
      String? notas});
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
    Object? nombre = null,
    Object? tipo = null,
    Object? vacantes = null,
    Object? location = null,
    Object? imageUrl = null,
    Object? descripcion = null,
    Object? resumen = null,
    Object? requisitos = null,
    Object? disponibilidad = null,
    Object? notas = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      vacantes: null == vacantes
          ? _value.vacantes
          : vacantes // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
      resumen: null == resumen
          ? _value.resumen
          : resumen // ignore: cast_nullable_to_non_nullable
              as String,
      requisitos: null == requisitos
          ? _value.requisitos
          : requisitos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      disponibilidad: null == disponibilidad
          ? _value.disponibilidad
          : disponibilidad // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notas: freezed == notas
          ? _value.notas
          : notas // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String nombre,
      String tipo,
      int vacantes,
      @GeoPointConverter() LatLng location,
      String imageUrl,
      String descripcion,
      String resumen,
      List<String> requisitos,
      List<String> disponibilidad,
      String? notas});
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
    Object? nombre = null,
    Object? tipo = null,
    Object? vacantes = null,
    Object? location = null,
    Object? imageUrl = null,
    Object? descripcion = null,
    Object? resumen = null,
    Object? requisitos = null,
    Object? disponibilidad = null,
    Object? notas = freezed,
  }) {
    return _then(_$VoluntariadoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      vacantes: null == vacantes
          ? _value.vacantes
          : vacantes // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
      resumen: null == resumen
          ? _value.resumen
          : resumen // ignore: cast_nullable_to_non_nullable
              as String,
      requisitos: null == requisitos
          ? _value._requisitos
          : requisitos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      disponibilidad: null == disponibilidad
          ? _value._disponibilidad
          : disponibilidad // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notas: freezed == notas
          ? _value.notas
          : notas // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoluntariadoImpl implements _Voluntariado {
  const _$VoluntariadoImpl(
      {required this.id,
      required this.nombre,
      required this.tipo,
      required this.vacantes,
      @GeoPointConverter() required this.location,
      required this.imageUrl,
      required this.descripcion,
      required this.resumen,
      required final List<String> requisitos,
      required final List<String> disponibilidad,
      this.notas})
      : _requisitos = requisitos,
        _disponibilidad = disponibilidad;

  factory _$VoluntariadoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoluntariadoImplFromJson(json);

  @override
  final String id;
  @override
  final String nombre;
  @override
  final String tipo;
  @override
  final int vacantes;
// required bool isLiked, // TODO, esto depende del usuario, no? No deberia estar dentro de la clase User?
  @override
  @GeoPointConverter()
  final LatLng location;
//    required VoluntariadoStatus estado, // TODO, esto depende del usuario, no? No deberia estar dentro de la clase User?
  @override
  final String imageUrl;
  @override
  final String descripcion;
  @override
  final String resumen;
  final List<String> _requisitos;
  @override
  List<String> get requisitos {
    if (_requisitos is EqualUnmodifiableListView) return _requisitos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requisitos);
  }

  final List<String> _disponibilidad;
  @override
  List<String> get disponibilidad {
    if (_disponibilidad is EqualUnmodifiableListView) return _disponibilidad;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_disponibilidad);
  }

// TODO que deje de ser string?
  @override
  final String? notas;

  @override
  String toString() {
    return 'Voluntariado(id: $id, nombre: $nombre, tipo: $tipo, vacantes: $vacantes, location: $location, imageUrl: $imageUrl, descripcion: $descripcion, resumen: $resumen, requisitos: $requisitos, disponibilidad: $disponibilidad, notas: $notas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoluntariadoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.vacantes, vacantes) ||
                other.vacantes == vacantes) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.descripcion, descripcion) ||
                other.descripcion == descripcion) &&
            (identical(other.resumen, resumen) || other.resumen == resumen) &&
            const DeepCollectionEquality()
                .equals(other._requisitos, _requisitos) &&
            const DeepCollectionEquality()
                .equals(other._disponibilidad, _disponibilidad) &&
            (identical(other.notas, notas) || other.notas == notas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nombre,
      tipo,
      vacantes,
      location,
      imageUrl,
      descripcion,
      resumen,
      const DeepCollectionEquality().hash(_requisitos),
      const DeepCollectionEquality().hash(_disponibilidad),
      notas);

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

abstract class _Voluntariado implements Voluntariado {
  const factory _Voluntariado(
      {required final String id,
      required final String nombre,
      required final String tipo,
      required final int vacantes,
      @GeoPointConverter() required final LatLng location,
      required final String imageUrl,
      required final String descripcion,
      required final String resumen,
      required final List<String> requisitos,
      required final List<String> disponibilidad,
      final String? notas}) = _$VoluntariadoImpl;

  factory _Voluntariado.fromJson(Map<String, dynamic> json) =
      _$VoluntariadoImpl.fromJson;

  @override
  String get id;
  @override
  String get nombre;
  @override
  String get tipo;
  @override
  int get vacantes; // required bool isLiked, // TODO, esto depende del usuario, no? No deberia estar dentro de la clase User?
  @override
  @GeoPointConverter()
  LatLng
      get location; //    required VoluntariadoStatus estado, // TODO, esto depende del usuario, no? No deberia estar dentro de la clase User?
  @override
  String get imageUrl;
  @override
  String get descripcion;
  @override
  String get resumen;
  @override
  List<String> get requisitos;
  @override
  List<String> get disponibilidad; // TODO que deje de ser string?
  @override
  String? get notas;

  /// Create a copy of Voluntariado
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoluntariadoImplCopyWith<_$VoluntariadoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
