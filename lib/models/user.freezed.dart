// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserVolunteering _$UserVolunteeringFromJson(Map<String, dynamic> json) {
  return _UserVolunteering.fromJson(json);
}

/// @nodoc
mixin _$UserVolunteering {
  String get id => throw _privateConstructorUsedError;
  VolunteeringUserState get estado => throw _privateConstructorUsedError;

  /// Serializes this UserVolunteering to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserVolunteering
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserVolunteeringCopyWith<UserVolunteering> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserVolunteeringCopyWith<$Res> {
  factory $UserVolunteeringCopyWith(
          UserVolunteering value, $Res Function(UserVolunteering) then) =
      _$UserVolunteeringCopyWithImpl<$Res, UserVolunteering>;
  @useResult
  $Res call({String id, VolunteeringUserState estado});
}

/// @nodoc
class _$UserVolunteeringCopyWithImpl<$Res, $Val extends UserVolunteering>
    implements $UserVolunteeringCopyWith<$Res> {
  _$UserVolunteeringCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserVolunteering
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? estado = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      estado: null == estado
          ? _value.estado
          : estado // ignore: cast_nullable_to_non_nullable
              as VolunteeringUserState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserVolunteeringImplCopyWith<$Res>
    implements $UserVolunteeringCopyWith<$Res> {
  factory _$$UserVolunteeringImplCopyWith(_$UserVolunteeringImpl value,
          $Res Function(_$UserVolunteeringImpl) then) =
      __$$UserVolunteeringImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, VolunteeringUserState estado});
}

/// @nodoc
class __$$UserVolunteeringImplCopyWithImpl<$Res>
    extends _$UserVolunteeringCopyWithImpl<$Res, _$UserVolunteeringImpl>
    implements _$$UserVolunteeringImplCopyWith<$Res> {
  __$$UserVolunteeringImplCopyWithImpl(_$UserVolunteeringImpl _value,
      $Res Function(_$UserVolunteeringImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserVolunteering
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? estado = null,
  }) {
    return _then(_$UserVolunteeringImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      estado: null == estado
          ? _value.estado
          : estado // ignore: cast_nullable_to_non_nullable
              as VolunteeringUserState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserVolunteeringImpl implements _UserVolunteering {
  const _$UserVolunteeringImpl({required this.id, required this.estado});

  factory _$UserVolunteeringImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserVolunteeringImplFromJson(json);

  @override
  final String id;
  @override
  final VolunteeringUserState estado;

  @override
  String toString() {
    return 'UserVolunteering(id: $id, estado: $estado)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserVolunteeringImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.estado, estado) || other.estado == estado));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, estado);

  /// Create a copy of UserVolunteering
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserVolunteeringImplCopyWith<_$UserVolunteeringImpl> get copyWith =>
      __$$UserVolunteeringImplCopyWithImpl<_$UserVolunteeringImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserVolunteeringImplToJson(
      this,
    );
  }
}

abstract class _UserVolunteering implements UserVolunteering {
  const factory _UserVolunteering(
      {required final String id,
      required final VolunteeringUserState estado}) = _$UserVolunteeringImpl;

  factory _UserVolunteering.fromJson(Map<String, dynamic> json) =
      _$UserVolunteeringImpl.fromJson;

  @override
  String get id;
  @override
  VolunteeringUserState get estado;

  /// Create a copy of UserVolunteering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserVolunteeringImplCopyWith<_$UserVolunteeringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  String get apellido => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get hasSeenOnboarding => throw _privateConstructorUsedError;
  @JsonKey(name: 'voluntariados')
  List<UserVolunteering>? get volunteerings =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'likedVoluntariados')
  List<String>? get likedVolunteerings => throw _privateConstructorUsedError;
  String? get telefono => throw _privateConstructorUsedError;
  DateTime? get fechaNacimiento => throw _privateConstructorUsedError;
  String? get genero => throw _privateConstructorUsedError;
  String? get imagenUrl => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String nombre,
      String apellido,
      String email,
      bool hasSeenOnboarding,
      @JsonKey(name: 'voluntariados') List<UserVolunteering>? volunteerings,
      @JsonKey(name: 'likedVoluntariados') List<String>? likedVolunteerings,
      String? telefono,
      DateTime? fechaNacimiento,
      String? genero,
      String? imagenUrl,
      String? fcmToken});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? apellido = null,
    Object? email = null,
    Object? hasSeenOnboarding = null,
    Object? volunteerings = freezed,
    Object? likedVolunteerings = freezed,
    Object? telefono = freezed,
    Object? fechaNacimiento = freezed,
    Object? genero = freezed,
    Object? imagenUrl = freezed,
    Object? fcmToken = freezed,
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
      apellido: null == apellido
          ? _value.apellido
          : apellido // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      hasSeenOnboarding: null == hasSeenOnboarding
          ? _value.hasSeenOnboarding
          : hasSeenOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
      volunteerings: freezed == volunteerings
          ? _value.volunteerings
          : volunteerings // ignore: cast_nullable_to_non_nullable
              as List<UserVolunteering>?,
      likedVolunteerings: freezed == likedVolunteerings
          ? _value.likedVolunteerings
          : likedVolunteerings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      telefono: freezed == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String?,
      fechaNacimiento: freezed == fechaNacimiento
          ? _value.fechaNacimiento
          : fechaNacimiento // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      genero: freezed == genero
          ? _value.genero
          : genero // ignore: cast_nullable_to_non_nullable
              as String?,
      imagenUrl: freezed == imagenUrl
          ? _value.imagenUrl
          : imagenUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nombre,
      String apellido,
      String email,
      bool hasSeenOnboarding,
      @JsonKey(name: 'voluntariados') List<UserVolunteering>? volunteerings,
      @JsonKey(name: 'likedVoluntariados') List<String>? likedVolunteerings,
      String? telefono,
      DateTime? fechaNacimiento,
      String? genero,
      String? imagenUrl,
      String? fcmToken});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? apellido = null,
    Object? email = null,
    Object? hasSeenOnboarding = null,
    Object? volunteerings = freezed,
    Object? likedVolunteerings = freezed,
    Object? telefono = freezed,
    Object? fechaNacimiento = freezed,
    Object? genero = freezed,
    Object? imagenUrl = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      apellido: null == apellido
          ? _value.apellido
          : apellido // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      hasSeenOnboarding: null == hasSeenOnboarding
          ? _value.hasSeenOnboarding
          : hasSeenOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
      volunteerings: freezed == volunteerings
          ? _value._volunteerings
          : volunteerings // ignore: cast_nullable_to_non_nullable
              as List<UserVolunteering>?,
      likedVolunteerings: freezed == likedVolunteerings
          ? _value._likedVolunteerings
          : likedVolunteerings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      telefono: freezed == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String?,
      fechaNacimiento: freezed == fechaNacimiento
          ? _value.fechaNacimiento
          : fechaNacimiento // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      genero: freezed == genero
          ? _value.genero
          : genero // ignore: cast_nullable_to_non_nullable
              as String?,
      imagenUrl: freezed == imagenUrl
          ? _value.imagenUrl
          : imagenUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.nombre,
      required this.apellido,
      required this.email,
      required this.hasSeenOnboarding,
      @JsonKey(name: 'voluntariados')
      final List<UserVolunteering>? volunteerings,
      @JsonKey(name: 'likedVoluntariados')
      final List<String>? likedVolunteerings,
      this.telefono,
      this.fechaNacimiento,
      this.genero,
      this.imagenUrl,
      this.fcmToken})
      : _volunteerings = volunteerings,
        _likedVolunteerings = likedVolunteerings;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String nombre;
  @override
  final String apellido;
  @override
  final String email;
  @override
  final bool hasSeenOnboarding;
  final List<UserVolunteering>? _volunteerings;
  @override
  @JsonKey(name: 'voluntariados')
  List<UserVolunteering>? get volunteerings {
    final value = _volunteerings;
    if (value == null) return null;
    if (_volunteerings is EqualUnmodifiableListView) return _volunteerings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _likedVolunteerings;
  @override
  @JsonKey(name: 'likedVoluntariados')
  List<String>? get likedVolunteerings {
    final value = _likedVolunteerings;
    if (value == null) return null;
    if (_likedVolunteerings is EqualUnmodifiableListView)
      return _likedVolunteerings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? telefono;
  @override
  final DateTime? fechaNacimiento;
  @override
  final String? genero;
  @override
  final String? imagenUrl;
  @override
  final String? fcmToken;

  @override
  String toString() {
    return 'User(id: $id, nombre: $nombre, apellido: $apellido, email: $email, hasSeenOnboarding: $hasSeenOnboarding, volunteerings: $volunteerings, likedVolunteerings: $likedVolunteerings, telefono: $telefono, fechaNacimiento: $fechaNacimiento, genero: $genero, imagenUrl: $imagenUrl, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.apellido, apellido) ||
                other.apellido == apellido) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.hasSeenOnboarding, hasSeenOnboarding) ||
                other.hasSeenOnboarding == hasSeenOnboarding) &&
            const DeepCollectionEquality()
                .equals(other._volunteerings, _volunteerings) &&
            const DeepCollectionEquality()
                .equals(other._likedVolunteerings, _likedVolunteerings) &&
            (identical(other.telefono, telefono) ||
                other.telefono == telefono) &&
            (identical(other.fechaNacimiento, fechaNacimiento) ||
                other.fechaNacimiento == fechaNacimiento) &&
            (identical(other.genero, genero) || other.genero == genero) &&
            (identical(other.imagenUrl, imagenUrl) ||
                other.imagenUrl == imagenUrl) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nombre,
      apellido,
      email,
      hasSeenOnboarding,
      const DeepCollectionEquality().hash(_volunteerings),
      const DeepCollectionEquality().hash(_likedVolunteerings),
      telefono,
      fechaNacimiento,
      genero,
      imagenUrl,
      fcmToken);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String nombre,
      required final String apellido,
      required final String email,
      required final bool hasSeenOnboarding,
      @JsonKey(name: 'voluntariados')
      final List<UserVolunteering>? volunteerings,
      @JsonKey(name: 'likedVoluntariados')
      final List<String>? likedVolunteerings,
      final String? telefono,
      final DateTime? fechaNacimiento,
      final String? genero,
      final String? imagenUrl,
      final String? fcmToken}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get nombre;
  @override
  String get apellido;
  @override
  String get email;
  @override
  bool get hasSeenOnboarding;
  @override
  @JsonKey(name: 'voluntariados')
  List<UserVolunteering>? get volunteerings;
  @override
  @JsonKey(name: 'likedVoluntariados')
  List<String>? get likedVolunteerings;
  @override
  String? get telefono;
  @override
  DateTime? get fechaNacimiento;
  @override
  String? get genero;
  @override
  String? get imagenUrl;
  @override
  String? get fcmToken;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
