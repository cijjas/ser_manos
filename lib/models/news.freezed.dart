// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

News _$NewsFromJson(Map<String, dynamic> json) {
  return _News.fromJson(json);
}

/// @nodoc
mixin _$News {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'titulo')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'resumen')
  String get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'emisor')
  String get sender => throw _privateConstructorUsedError;
  @TrimConverter()
  @JsonKey(name: 'imagenUrl')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'descripcion')
  String get description => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this News to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsCopyWith<News> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsCopyWith<$Res> {
  factory $NewsCopyWith(News value, $Res Function(News) then) =
      _$NewsCopyWithImpl<$Res, News>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'titulo') String title,
      @JsonKey(name: 'resumen') String summary,
      @JsonKey(name: 'emisor') String sender,
      @TrimConverter() @JsonKey(name: 'imagenUrl') String imageUrl,
      @JsonKey(name: 'descripcion') String description,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$NewsCopyWithImpl<$Res, $Val extends News>
    implements $NewsCopyWith<$Res> {
  _$NewsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? summary = null,
    Object? sender = null,
    Object? imageUrl = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsImplCopyWith<$Res> implements $NewsCopyWith<$Res> {
  factory _$$NewsImplCopyWith(
          _$NewsImpl value, $Res Function(_$NewsImpl) then) =
      __$$NewsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'titulo') String title,
      @JsonKey(name: 'resumen') String summary,
      @JsonKey(name: 'emisor') String sender,
      @TrimConverter() @JsonKey(name: 'imagenUrl') String imageUrl,
      @JsonKey(name: 'descripcion') String description,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$NewsImplCopyWithImpl<$Res>
    extends _$NewsCopyWithImpl<$Res, _$NewsImpl>
    implements _$$NewsImplCopyWith<$Res> {
  __$$NewsImplCopyWithImpl(_$NewsImpl _value, $Res Function(_$NewsImpl) _then)
      : super(_value, _then);

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? summary = null,
    Object? sender = null,
    Object? imageUrl = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(_$NewsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsImpl implements _News {
  const _$NewsImpl(
      {required this.id,
      @JsonKey(name: 'titulo') required this.title,
      @JsonKey(name: 'resumen') required this.summary,
      @JsonKey(name: 'emisor') required this.sender,
      @TrimConverter() @JsonKey(name: 'imagenUrl') required this.imageUrl,
      @JsonKey(name: 'descripcion') required this.description,
      @TimestampConverter() required this.createdAt});

  factory _$NewsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'titulo')
  final String title;
  @override
  @JsonKey(name: 'resumen')
  final String summary;
  @override
  @JsonKey(name: 'emisor')
  final String sender;
  @override
  @TrimConverter()
  @JsonKey(name: 'imagenUrl')
  final String imageUrl;
  @override
  @JsonKey(name: 'descripcion')
  final String description;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'News(id: $id, title: $title, summary: $summary, sender: $sender, imageUrl: $imageUrl, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, summary, sender,
      imageUrl, description, createdAt);

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsImplCopyWith<_$NewsImpl> get copyWith =>
      __$$NewsImplCopyWithImpl<_$NewsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsImplToJson(
      this,
    );
  }
}

abstract class _News implements News {
  const factory _News(
      {required final String id,
      @JsonKey(name: 'titulo') required final String title,
      @JsonKey(name: 'resumen') required final String summary,
      @JsonKey(name: 'emisor') required final String sender,
      @TrimConverter()
      @JsonKey(name: 'imagenUrl')
      required final String imageUrl,
      @JsonKey(name: 'descripcion') required final String description,
      @TimestampConverter() required final DateTime createdAt}) = _$NewsImpl;

  factory _News.fromJson(Map<String, dynamic> json) = _$NewsImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'titulo')
  String get title;
  @override
  @JsonKey(name: 'resumen')
  String get summary;
  @override
  @JsonKey(name: 'emisor')
  String get sender;
  @override
  @TrimConverter()
  @JsonKey(name: 'imagenUrl')
  String get imageUrl;
  @override
  @JsonKey(name: 'descripcion')
  String get description;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsImplCopyWith<_$NewsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
