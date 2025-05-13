// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novedad.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Novedad _$NovedadFromJson(Map<String, dynamic> json) {
  return _Novedad.fromJson(json);
}

/// @nodoc
mixin _$Novedad {
  String get id => throw _privateConstructorUsedError;
  String get titulo => throw _privateConstructorUsedError;
  String get resumen => throw _privateConstructorUsedError;
  String get emisor => throw _privateConstructorUsedError;
  String get imagenUrl => throw _privateConstructorUsedError;
  String get descripcion => throw _privateConstructorUsedError;

  /// Serializes this Novedad to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Novedad
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovedadCopyWith<Novedad> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovedadCopyWith<$Res> {
  factory $NovedadCopyWith(Novedad value, $Res Function(Novedad) then) =
      _$NovedadCopyWithImpl<$Res, Novedad>;
  @useResult
  $Res call(
      {String id,
      String titulo,
      String resumen,
      String emisor,
      String imagenUrl,
      String descripcion});
}

/// @nodoc
class _$NovedadCopyWithImpl<$Res, $Val extends Novedad>
    implements $NovedadCopyWith<$Res> {
  _$NovedadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Novedad
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titulo = null,
    Object? resumen = null,
    Object? emisor = null,
    Object? imagenUrl = null,
    Object? descripcion = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titulo: null == titulo
          ? _value.titulo
          : titulo // ignore: cast_nullable_to_non_nullable
              as String,
      resumen: null == resumen
          ? _value.resumen
          : resumen // ignore: cast_nullable_to_non_nullable
              as String,
      emisor: null == emisor
          ? _value.emisor
          : emisor // ignore: cast_nullable_to_non_nullable
              as String,
      imagenUrl: null == imagenUrl
          ? _value.imagenUrl
          : imagenUrl // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovedadImplCopyWith<$Res> implements $NovedadCopyWith<$Res> {
  factory _$$NovedadImplCopyWith(
          _$NovedadImpl value, $Res Function(_$NovedadImpl) then) =
      __$$NovedadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String titulo,
      String resumen,
      String emisor,
      String imagenUrl,
      String descripcion});
}

/// @nodoc
class __$$NovedadImplCopyWithImpl<$Res>
    extends _$NovedadCopyWithImpl<$Res, _$NovedadImpl>
    implements _$$NovedadImplCopyWith<$Res> {
  __$$NovedadImplCopyWithImpl(
      _$NovedadImpl _value, $Res Function(_$NovedadImpl) _then)
      : super(_value, _then);

  /// Create a copy of Novedad
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titulo = null,
    Object? resumen = null,
    Object? emisor = null,
    Object? imagenUrl = null,
    Object? descripcion = null,
  }) {
    return _then(_$NovedadImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titulo: null == titulo
          ? _value.titulo
          : titulo // ignore: cast_nullable_to_non_nullable
              as String,
      resumen: null == resumen
          ? _value.resumen
          : resumen // ignore: cast_nullable_to_non_nullable
              as String,
      emisor: null == emisor
          ? _value.emisor
          : emisor // ignore: cast_nullable_to_non_nullable
              as String,
      imagenUrl: null == imagenUrl
          ? _value.imagenUrl
          : imagenUrl // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovedadImpl implements _Novedad {
  const _$NovedadImpl(
      {required this.id,
      required this.titulo,
      required this.resumen,
      required this.emisor,
      required this.imagenUrl,
      required this.descripcion});

  factory _$NovedadImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovedadImplFromJson(json);

  @override
  final String id;
  @override
  final String titulo;
  @override
  final String resumen;
  @override
  final String emisor;
  @override
  final String imagenUrl;
  @override
  final String descripcion;

  @override
  String toString() {
    return 'Novedad(id: $id, titulo: $titulo, resumen: $resumen, emisor: $emisor, imagenUrl: $imagenUrl, descripcion: $descripcion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovedadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titulo, titulo) || other.titulo == titulo) &&
            (identical(other.resumen, resumen) || other.resumen == resumen) &&
            (identical(other.emisor, emisor) || other.emisor == emisor) &&
            (identical(other.imagenUrl, imagenUrl) ||
                other.imagenUrl == imagenUrl) &&
            (identical(other.descripcion, descripcion) ||
                other.descripcion == descripcion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, titulo, resumen, emisor, imagenUrl, descripcion);

  /// Create a copy of Novedad
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovedadImplCopyWith<_$NovedadImpl> get copyWith =>
      __$$NovedadImplCopyWithImpl<_$NovedadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovedadImplToJson(
      this,
    );
  }
}

abstract class _Novedad implements Novedad {
  const factory _Novedad(
      {required final String id,
      required final String titulo,
      required final String resumen,
      required final String emisor,
      required final String imagenUrl,
      required final String descripcion}) = _$NovedadImpl;

  factory _Novedad.fromJson(Map<String, dynamic> json) = _$NovedadImpl.fromJson;

  @override
  String get id;
  @override
  String get titulo;
  @override
  String get resumen;
  @override
  String get emisor;
  @override
  String get imagenUrl;
  @override
  String get descripcion;

  /// Create a copy of Novedad
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovedadImplCopyWith<_$NovedadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
