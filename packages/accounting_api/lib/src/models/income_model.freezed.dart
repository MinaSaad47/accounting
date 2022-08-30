// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'income_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IncomeModel _$IncomeModelFromJson(Map<String, dynamic> json) {
  return _IncomeModel.fromJson(json);
}

/// @nodoc
mixin _$IncomeModel {
  int? get id => throw _privateConstructorUsedError;
  num get value => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  DateTime? get time => throw _privateConstructorUsedError;
  @JsonKey(name: 'company')
  String? get companyName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncomeModelCopyWith<IncomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeModelCopyWith<$Res> {
  factory $IncomeModelCopyWith(
          IncomeModel value, $Res Function(IncomeModel) then) =
      _$IncomeModelCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      num value,
      String description,
      @DatetimeJsonConverter() DateTime? time,
      @JsonKey(name: 'company') String? companyName});
}

/// @nodoc
class _$IncomeModelCopyWithImpl<$Res> implements $IncomeModelCopyWith<$Res> {
  _$IncomeModelCopyWithImpl(this._value, this._then);

  final IncomeModel _value;
  // ignore: unused_field
  final $Res Function(IncomeModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? value = freezed,
    Object? description = freezed,
    Object? time = freezed,
    Object? companyName = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      companyName: companyName == freezed
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_IncomeModelCopyWith<$Res>
    implements $IncomeModelCopyWith<$Res> {
  factory _$$_IncomeModelCopyWith(
          _$_IncomeModel value, $Res Function(_$_IncomeModel) then) =
      __$$_IncomeModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      num value,
      String description,
      @DatetimeJsonConverter() DateTime? time,
      @JsonKey(name: 'company') String? companyName});
}

/// @nodoc
class __$$_IncomeModelCopyWithImpl<$Res> extends _$IncomeModelCopyWithImpl<$Res>
    implements _$$_IncomeModelCopyWith<$Res> {
  __$$_IncomeModelCopyWithImpl(
      _$_IncomeModel _value, $Res Function(_$_IncomeModel) _then)
      : super(_value, (v) => _then(v as _$_IncomeModel));

  @override
  _$_IncomeModel get _value => super._value as _$_IncomeModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? value = freezed,
    Object? description = freezed,
    Object? time = freezed,
    Object? companyName = freezed,
  }) {
    return _then(_$_IncomeModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      companyName: companyName == freezed
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IncomeModel implements _IncomeModel {
  const _$_IncomeModel(
      {this.id,
      required this.value,
      required this.description,
      @DatetimeJsonConverter() this.time,
      @JsonKey(name: 'company') this.companyName});

  factory _$_IncomeModel.fromJson(Map<String, dynamic> json) =>
      _$$_IncomeModelFromJson(json);

  @override
  final int? id;
  @override
  final num value;
  @override
  final String description;
  @override
  @DatetimeJsonConverter()
  final DateTime? time;
  @override
  @JsonKey(name: 'company')
  final String? companyName;

  @override
  String toString() {
    return 'IncomeModel(id: $id, value: $value, description: $description, time: $time, companyName: $companyName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IncomeModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.time, time) &&
            const DeepCollectionEquality()
                .equals(other.companyName, companyName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(time),
      const DeepCollectionEquality().hash(companyName));

  @JsonKey(ignore: true)
  @override
  _$$_IncomeModelCopyWith<_$_IncomeModel> get copyWith =>
      __$$_IncomeModelCopyWithImpl<_$_IncomeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IncomeModelToJson(
      this,
    );
  }
}

abstract class _IncomeModel implements IncomeModel {
  const factory _IncomeModel(
      {final int? id,
      required final num value,
      required final String description,
      @DatetimeJsonConverter() final DateTime? time,
      @JsonKey(name: 'company') final String? companyName}) = _$_IncomeModel;

  factory _IncomeModel.fromJson(Map<String, dynamic> json) =
      _$_IncomeModel.fromJson;

  @override
  int? get id;
  @override
  num get value;
  @override
  String get description;
  @override
  @DatetimeJsonConverter()
  DateTime? get time;
  @override
  @JsonKey(name: 'company')
  String? get companyName;
  @override
  @JsonKey(ignore: true)
  _$$_IncomeModelCopyWith<_$_IncomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
