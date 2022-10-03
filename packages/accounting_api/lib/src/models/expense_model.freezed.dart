// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) {
  return _ExpenseModel.fromJson(json);
}

/// @nodoc
mixin _$ExpenseModel {
  String? get id => throw _privateConstructorUsedError;
  num get value => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  DateTime? get time => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  String? get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'company')
  String? get companyName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseModelCopyWith<ExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseModelCopyWith<$Res> {
  factory $ExpenseModelCopyWith(
          ExpenseModel value, $Res Function(ExpenseModel) then) =
      _$ExpenseModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      num value,
      String description,
      @DatetimeJsonConverter() DateTime? time,
      @JsonKey(name: 'user') String? userName,
      @JsonKey(name: 'company') String? companyName});
}

/// @nodoc
class _$ExpenseModelCopyWithImpl<$Res> implements $ExpenseModelCopyWith<$Res> {
  _$ExpenseModelCopyWithImpl(this._value, this._then);

  final ExpenseModel _value;
  // ignore: unused_field
  final $Res Function(ExpenseModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? value = freezed,
    Object? description = freezed,
    Object? time = freezed,
    Object? userName = freezed,
    Object? companyName = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: companyName == freezed
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ExpenseModelCopyWith<$Res>
    implements $ExpenseModelCopyWith<$Res> {
  factory _$$_ExpenseModelCopyWith(
          _$_ExpenseModel value, $Res Function(_$_ExpenseModel) then) =
      __$$_ExpenseModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      num value,
      String description,
      @DatetimeJsonConverter() DateTime? time,
      @JsonKey(name: 'user') String? userName,
      @JsonKey(name: 'company') String? companyName});
}

/// @nodoc
class __$$_ExpenseModelCopyWithImpl<$Res>
    extends _$ExpenseModelCopyWithImpl<$Res>
    implements _$$_ExpenseModelCopyWith<$Res> {
  __$$_ExpenseModelCopyWithImpl(
      _$_ExpenseModel _value, $Res Function(_$_ExpenseModel) _then)
      : super(_value, (v) => _then(v as _$_ExpenseModel));

  @override
  _$_ExpenseModel get _value => super._value as _$_ExpenseModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? value = freezed,
    Object? description = freezed,
    Object? time = freezed,
    Object? userName = freezed,
    Object? companyName = freezed,
  }) {
    return _then(_$_ExpenseModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: companyName == freezed
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExpenseModel implements _ExpenseModel {
  const _$_ExpenseModel(
      {this.id,
      required this.value,
      required this.description,
      @DatetimeJsonConverter() this.time,
      @JsonKey(name: 'user') this.userName,
      @JsonKey(name: 'company') this.companyName});

  factory _$_ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$$_ExpenseModelFromJson(json);

  @override
  final String? id;
  @override
  final num value;
  @override
  final String description;
  @override
  @DatetimeJsonConverter()
  final DateTime? time;
  @override
  @JsonKey(name: 'user')
  final String? userName;
  @override
  @JsonKey(name: 'company')
  final String? companyName;

  @override
  String toString() {
    return 'ExpenseModel(id: $id, value: $value, description: $description, time: $time, userName: $userName, companyName: $companyName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpenseModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.time, time) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
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
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(companyName));

  @JsonKey(ignore: true)
  @override
  _$$_ExpenseModelCopyWith<_$_ExpenseModel> get copyWith =>
      __$$_ExpenseModelCopyWithImpl<_$_ExpenseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpenseModelToJson(
      this,
    );
  }
}

abstract class _ExpenseModel implements ExpenseModel {
  const factory _ExpenseModel(
      {final String? id,
      required final num value,
      required final String description,
      @DatetimeJsonConverter() final DateTime? time,
      @JsonKey(name: 'user') final String? userName,
      @JsonKey(name: 'company') final String? companyName}) = _$_ExpenseModel;

  factory _ExpenseModel.fromJson(Map<String, dynamic> json) =
      _$_ExpenseModel.fromJson;

  @override
  String? get id;
  @override
  num get value;
  @override
  String get description;
  @override
  @DatetimeJsonConverter()
  DateTime? get time;
  @override
  @JsonKey(name: 'user')
  String? get userName;
  @override
  @JsonKey(name: 'company')
  String? get companyName;
  @override
  @JsonKey(ignore: true)
  _$$_ExpenseModelCopyWith<_$_ExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
