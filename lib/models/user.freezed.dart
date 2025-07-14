// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserVolunteering {
  String get id;
  VolunteeringUserState get estado;

  /// Create a copy of UserVolunteering
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserVolunteeringCopyWith<UserVolunteering> get copyWith =>
      _$UserVolunteeringCopyWithImpl<UserVolunteering>(
          this as UserVolunteering, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserVolunteering &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.estado, estado) || other.estado == estado));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, estado);

  @override
  String toString() {
    return 'UserVolunteering(id: $id, estado: $estado)';
  }
}

/// @nodoc
abstract mixin class $UserVolunteeringCopyWith<$Res> {
  factory $UserVolunteeringCopyWith(
          UserVolunteering value, $Res Function(UserVolunteering) _then) =
      _$UserVolunteeringCopyWithImpl;
  @useResult
  $Res call({String id, VolunteeringUserState estado});
}

/// @nodoc
class _$UserVolunteeringCopyWithImpl<$Res>
    implements $UserVolunteeringCopyWith<$Res> {
  _$UserVolunteeringCopyWithImpl(this._self, this._then);

  final UserVolunteering _self;
  final $Res Function(UserVolunteering) _then;

  /// Create a copy of UserVolunteering
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? estado = null,
  }) {
    return _then(UserVolunteering(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      estado: null == estado
          ? _self.estado
          : estado // ignore: cast_nullable_to_non_nullable
              as VolunteeringUserState,
    ));
  }
}

/// @nodoc
mixin _$User {
  String get id;
  String get name;
  String get surname;
  String get email;
  bool get hasSeenOnboarding;
  List<UserVolunteering>? get volunteerings;
  List<String>? get likedVolunteerings;
  String? get phoneNumber;
  DateTime? get birthDate;
  String? get gender;
  String? get imageUrl;
  String? get fcmToken;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserCopyWith<User> get copyWith =>
      _$UserCopyWithImpl<User>(this as User, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.hasSeenOnboarding, hasSeenOnboarding) ||
                other.hasSeenOnboarding == hasSeenOnboarding) &&
            const DeepCollectionEquality()
                .equals(other.volunteerings, volunteerings) &&
            const DeepCollectionEquality()
                .equals(other.likedVolunteerings, likedVolunteerings) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      surname,
      email,
      hasSeenOnboarding,
      const DeepCollectionEquality().hash(volunteerings),
      const DeepCollectionEquality().hash(likedVolunteerings),
      phoneNumber,
      birthDate,
      gender,
      imageUrl,
      fcmToken);

  @override
  String toString() {
    return 'User(id: $id, name: $name, surname: $surname, email: $email, hasSeenOnboarding: $hasSeenOnboarding, volunteerings: $volunteerings, likedVolunteerings: $likedVolunteerings, phoneNumber: $phoneNumber, birthDate: $birthDate, gender: $gender, imageUrl: $imageUrl, fcmToken: $fcmToken)';
  }
}

/// @nodoc
abstract mixin class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) _then) =
      _$UserCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String surname,
      String email,
      bool hasSeenOnboarding,
      List<UserVolunteering>? volunteerings,
      List<String>? likedVolunteerings,
      String? phoneNumber,
      DateTime? birthDate,
      String? gender,
      String? imageUrl,
      String? fcmToken});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? hasSeenOnboarding = null,
    Object? volunteerings = freezed,
    Object? likedVolunteerings = freezed,
    Object? phoneNumber = freezed,
    Object? birthDate = freezed,
    Object? gender = freezed,
    Object? imageUrl = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(User(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      hasSeenOnboarding: null == hasSeenOnboarding
          ? _self.hasSeenOnboarding
          : hasSeenOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
      volunteerings: freezed == volunteerings
          ? _self.volunteerings
          : volunteerings // ignore: cast_nullable_to_non_nullable
              as List<UserVolunteering>?,
      likedVolunteerings: freezed == likedVolunteerings
          ? _self.likedVolunteerings
          : likedVolunteerings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _self.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: freezed == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _self.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
