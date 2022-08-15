// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'funder_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FunderModel _$FunderModelFromJson(Map<String, dynamic> json) {
  return _FunderModel.fromJson(json);
}

/// @nodoc
mixin _$FunderModel {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FunderModelCopyWith<FunderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FunderModelCopyWith<$Res> {
  factory $FunderModelCopyWith(
          FunderModel value, $Res Function(FunderModel) then) =
      _$FunderModelCopyWithImpl<$Res>;
  $Res call({String? id, String name});
}

/// @nodoc
class _$FunderModelCopyWithImpl<$Res> implements $FunderModelCopyWith<$Res> {
  _$FunderModelCopyWithImpl(this._value, this._then);

  final FunderModel _value;
  // ignore: unused_field
  final $Res Function(FunderModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_FunderModelCopyWith<$Res>
    implements $FunderModelCopyWith<$Res> {
  factory _$$_FunderModelCopyWith(
          _$_FunderModel value, $Res Function(_$_FunderModel) then) =
      __$$_FunderModelCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String name});
}

/// @nodoc
class __$$_FunderModelCopyWithImpl<$Res> extends _$FunderModelCopyWithImpl<$Res>
    implements _$$_FunderModelCopyWith<$Res> {
  __$$_FunderModelCopyWithImpl(
      _$_FunderModel _value, $Res Function(_$_FunderModel) _then)
      : super(_value, (v) => _then(v as _$_FunderModel));

  @override
  _$_FunderModel get _value => super._value as _$_FunderModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_FunderModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FunderModel implements _FunderModel {
  const _$_FunderModel({this.id, required this.name});

  factory _$_FunderModel.fromJson(Map<String, dynamic> json) =>
      _$$_FunderModelFromJson(json);

  @override
  final String? id;
  @override
  final String name;

  @override
  String toString() {
    return 'FunderModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FunderModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_FunderModelCopyWith<_$_FunderModel> get copyWith =>
      __$$_FunderModelCopyWithImpl<_$_FunderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FunderModelToJson(
      this,
    );
  }
}

abstract class _FunderModel implements FunderModel {
  const factory _FunderModel({final String? id, required final String name}) =
      _$_FunderModel;

  factory _FunderModel.fromJson(Map<String, dynamic> json) =
      _$_FunderModel.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_FunderModelCopyWith<_$_FunderModel> get copyWith =>
      throw _privateConstructorUsedError;
}
