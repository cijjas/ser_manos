part of 'user.dart';

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserVoluntariado _$UserVoluntariadoFromJson(Map<String, dynamic> json) {
  return _UserVoluntariado.fromJson(json);
}

mixin _$UserVoluntariado {
  String get id => throw _privateConstructorUsedError;
  VoluntariadoUserState get estado => throw _privateConstructorUsedError;

  /// Serializes this UserVoluntariado to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserVoluntariado
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserVoluntariadoCopyWith<UserVoluntariado> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $UserVoluntariadoCopyWith<$Res> {
  factory $UserVoluntariadoCopyWith(
          UserVoluntariado value, $Res Function(UserVoluntariado) then) =
      _$UserVoluntariadoCopyWithImpl<$Res, UserVoluntariado>;
  @useResult
  $Res call({String id, VoluntariadoUserState estado});
}

class _$UserVoluntariadoCopyWithImpl<$Res, $Val extends UserVoluntariado>
    implements $UserVoluntariadoCopyWith<$Res> {
  _$UserVoluntariadoCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  /// Create a copy of UserVoluntariado
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? estado = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as String,
      estado: null == estado
          ? _value.estado
          : estado
              as VoluntariadoUserState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserVoluntariadoImplCopyWith<$Res>
    implements $UserVoluntariadoCopyWith<$Res> {
  factory _$$UserVoluntariadoImplCopyWith(_$UserVoluntariadoImpl value,
          $Res Function(_$UserVoluntariadoImpl) then) =
      __$$UserVoluntariadoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, VoluntariadoUserState estado});
}

/// @nodoc
class __$$UserVoluntariadoImplCopyWithImpl<$Res>
    extends _$UserVoluntariadoCopyWithImpl<$Res, _$UserVoluntariadoImpl>
    implements _$$UserVoluntariadoImplCopyWith<$Res> {
  __$$UserVoluntariadoImplCopyWithImpl(_$UserVoluntariadoImpl _value,
      $Res Function(_$UserVoluntariadoImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserVoluntariado
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? estado = null,
  }) {
    return _then(_$UserVoluntariadoImpl(
      id: null == id
          ? _value.id
          : id 
              as String,
      estado: null == estado
          ? _value.estado
          : estado 
              as VoluntariadoUserState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserVoluntariadoImpl implements _UserVoluntariado {
  const _$UserVoluntariadoImpl({required this.id, required this.estado});

  factory _$UserVoluntariadoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserVoluntariadoImplFromJson(json);

  @override
  final String id;
  @override
  final VoluntariadoUserState estado;

  @override
  String toString() {
    return 'UserVoluntariado(id: $id, estado: $estado)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserVoluntariadoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.estado, estado) || other.estado == estado));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, estado);

  /// Create a copy of UserVoluntariado
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserVoluntariadoImplCopyWith<_$UserVoluntariadoImpl> get copyWith =>
      __$$UserVoluntariadoImplCopyWithImpl<_$UserVoluntariadoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserVoluntariadoImplToJson(
      this,
    );
  }
}

abstract class _UserVoluntariado implements UserVoluntariado {
  const factory _UserVoluntariado(
      {required final String id,
      required final VoluntariadoUserState estado}) = _$UserVoluntariadoImpl;

  factory _UserVoluntariado.fromJson(Map<String, dynamic> json) =
      _$UserVoluntariadoImpl.fromJson;

  @override
  String get id;
  @override
  VoluntariadoUserState get estado;

  /// Create a copy of UserVoluntariado
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserVoluntariadoImplCopyWith<_$UserVoluntariadoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  String get apellido => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool? get hasSeenOnboarding => throw _privateConstructorUsedError;
  List<UserVoluntariado>? get voluntariados =>
      throw _privateConstructorUsedError;
  List<String>? get likedVoluntariados => throw _privateConstructorUsedError;
  String? get telefono => throw _privateConstructorUsedError;
  DateTime? get fechaNacimiento => throw _privateConstructorUsedError;
  String? get genero => throw _privateConstructorUsedError;
  String? get imagenUrl => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String nombre,
      String apellido,
      String email,
      bool? hasSeenOnboarding,
      List<UserVoluntariado>? voluntariados,
      List<String>? likedVoluntariados,
      String? telefono,
      DateTime? fechaNacimiento,
      String? genero,
      String? imagenUrl,
      String? fcmToken});
}

class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  /// Create a copy of User
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? apellido = null,
    Object? email = null,
    Object? hasSeenOnboarding = freezed,
    Object? voluntariados = freezed,
    Object? likedVoluntariados = freezed,
    Object? telefono = freezed,
    Object? fechaNacimiento = freezed,
    Object? genero = freezed,
    Object? imagenUrl = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre 
              as String,
      apellido: null == apellido
          ? _value.apellido
          : apellido
              as String,
      email: null == email
          ? _value.email
          : email 
              as String,
      hasSeenOnboarding: freezed == hasSeenOnboarding
          ? _value.hasSeenOnboarding
          : hasSeenOnboarding 
              as bool?,
      voluntariados: freezed == voluntariados
          ? _value.voluntariados
          : voluntariados 
              as List<UserVoluntariado>?,
      likedVoluntariados: freezed == likedVoluntariados
          ? _value.likedVoluntariados
          : likedVoluntariados
              as List<String>?,
      telefono: freezed == telefono
          ? _value.telefono
          : telefono 
              as String?,
      fechaNacimiento: freezed == fechaNacimiento
          ? _value.fechaNacimiento
          : fechaNacimiento 
              as DateTime?,
      genero: freezed == genero
          ? _value.genero
          : genero 
              as String?,
      imagenUrl: freezed == imagenUrl
          ? _value.imagenUrl
          : imagenUrl 
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken 
              as String?,
    ) as $Val);
  }
}

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
      bool? hasSeenOnboarding,
      List<UserVoluntariado>? voluntariados,
      List<String>? likedVoluntariados,
      String? telefono,
      DateTime? fechaNacimiento,
      String? genero,
      String? imagenUrl,
      String? fcmToken});
}

class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? apellido = null,
    Object? email = null,
    Object? hasSeenOnboarding = freezed,
    Object? voluntariados = freezed,
    Object? likedVoluntariados = freezed,
    Object? telefono = freezed,
    Object? fechaNacimiento = freezed,
    Object? genero = freezed,
    Object? imagenUrl = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id 
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre 
              as String,
      apellido: null == apellido
          ? _value.apellido
          : apellido
              as String,
      email: null == email
          ? _value.email
          : email 
              as String,
      hasSeenOnboarding: freezed == hasSeenOnboarding
          ? _value.hasSeenOnboarding
          : hasSeenOnboarding 
              as bool?,
      voluntariados: freezed == voluntariados
          ? _value._voluntariados
          : voluntariados 
              as List<UserVoluntariado>?,
      likedVoluntariados: freezed == likedVoluntariados
          ? _value._likedVoluntariados
          : likedVoluntariados 
              as List<String>?,
      telefono: freezed == telefono
          ? _value.telefono
          : telefono 
              as String?,
      fechaNacimiento: freezed == fechaNacimiento
          ? _value.fechaNacimiento
          : fechaNacimiento 
              as DateTime?,
      genero: freezed == genero
          ? _value.genero
          : genero 
              as String?,
      imagenUrl: freezed == imagenUrl
          ? _value.imagenUrl
          : imagenUrl 
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken 
              as String?,
    ));
  }
}

@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.nombre,
      required this.apellido,
      required this.email,
      this.hasSeenOnboarding,
      final List<UserVoluntariado>? voluntariados,
      final List<String>? likedVoluntariados,
      this.telefono,
      this.fechaNacimiento,
      this.genero,
      this.imagenUrl,
      this.fcmToken})
      : _voluntariados = voluntariados,
        _likedVoluntariados = likedVoluntariados;

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
  final bool? hasSeenOnboarding;
  final List<UserVoluntariado>? _voluntariados;
  @override
  List<UserVoluntariado>? get voluntariados {
    final value = _voluntariados;
    if (value == null) return null;
    if (_voluntariados is EqualUnmodifiableListView) return _voluntariados;
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _likedVoluntariados;
  @override
  List<String>? get likedVoluntariados {
    final value = _likedVoluntariados;
    if (value == null) return null;
    if (_likedVoluntariados is EqualUnmodifiableListView)
      return _likedVoluntariados;
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
    return 'User(id: $id, nombre: $nombre, apellido: $apellido, email: $email, hasSeenOnboarding: $hasSeenOnboarding, voluntariados: $voluntariados, likedVoluntariados: $likedVoluntariados, telefono: $telefono, fechaNacimiento: $fechaNacimiento, genero: $genero, imagenUrl: $imagenUrl, fcmToken: $fcmToken)';
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
                .equals(other._voluntariados, _voluntariados) &&
            const DeepCollectionEquality()
                .equals(other._likedVoluntariados, _likedVoluntariados) &&
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
      const DeepCollectionEquality().hash(_voluntariados),
      const DeepCollectionEquality().hash(_likedVoluntariados),
      telefono,
      fechaNacimiento,
      genero,
      imagenUrl,
      fcmToken);

  /// Create a copy of User
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
      final bool? hasSeenOnboarding,
      final List<UserVoluntariado>? voluntariados,
      final List<String>? likedVoluntariados,
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
  bool? get hasSeenOnboarding;
  @override
  List<UserVoluntariado>? get voluntariados;
  @override
  List<String>? get likedVoluntariados;
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
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
