// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'document_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) {
  return _DocumentModel.fromJson(json);
}

/// @nodoc
mixin _$DocumentModel {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  DateTime get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentModelCopyWith<DocumentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentModelCopyWith<$Res> {
  factory $DocumentModelCopyWith(
          DocumentModel value, $Res Function(DocumentModel) then) =
      _$DocumentModelCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String name,
      String path,
      @DatetimeJsonConverter() DateTime time});
}

/// @nodoc
class _$DocumentModelCopyWithImpl<$Res>
    implements $DocumentModelCopyWith<$Res> {
  _$DocumentModelCopyWithImpl(this._value, this._then);

  final DocumentModel _value;
  // ignore: unused_field
  final $Res Function(DocumentModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? path = freezed,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_DocumentModelCopyWith<$Res>
    implements $DocumentModelCopyWith<$Res> {
  factory _$$_DocumentModelCopyWith(
          _$_DocumentModel value, $Res Function(_$_DocumentModel) then) =
      __$$_DocumentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String name,
      String path,
      @DatetimeJsonConverter() DateTime time});
}

/// @nodoc
class __$$_DocumentModelCopyWithImpl<$Res>
    extends _$DocumentModelCopyWithImpl<$Res>
    implements _$$_DocumentModelCopyWith<$Res> {
  __$$_DocumentModelCopyWithImpl(
      _$_DocumentModel _value, $Res Function(_$_DocumentModel) _then)
      : super(_value, (v) => _then(v as _$_DocumentModel));

  @override
  _$_DocumentModel get _value => super._value as _$_DocumentModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? path = freezed,
    Object? time = freezed,
  }) {
    return _then(_$_DocumentModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DocumentModel implements _DocumentModel {
  const _$_DocumentModel(
      {this.id,
      required this.name,
      required this.path,
      @DatetimeJsonConverter() required this.time});

  factory _$_DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$$_DocumentModelFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final String path;
  @override
  @DatetimeJsonConverter()
  final DateTime time;

  @override
  String toString() {
    return 'DocumentModel(id: $id, name: $name, path: $path, time: $time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DocumentModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.time, time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(time));

  @JsonKey(ignore: true)
  @override
  _$$_DocumentModelCopyWith<_$_DocumentModel> get copyWith =>
      __$$_DocumentModelCopyWithImpl<_$_DocumentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DocumentModelToJson(
      this,
    );
  }
}

abstract class _DocumentModel implements DocumentModel {
  const factory _DocumentModel(
          {final int? id,
          required final String name,
          required final String path,
          @DatetimeJsonConverter() required final DateTime time}) =
      _$_DocumentModel;

  factory _DocumentModel.fromJson(Map<String, dynamic> json) =
      _$_DocumentModel.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  String get path;
  @override
  @DatetimeJsonConverter()
  DateTime get time;
  @override
  @JsonKey(ignore: true)
  _$$_DocumentModelCopyWith<_$_DocumentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
