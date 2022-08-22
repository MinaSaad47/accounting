// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'money_capital_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyCapitalModel _$MoneyCapitalModelFromJson(Map<String, dynamic> json) {
  return _MoneyCapitalModel.fromJson(json);
}

/// @nodoc
mixin _$MoneyCapitalModel {
  int? get id => throw _privateConstructorUsedError;
  num get value => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_name')
  String? get companyName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyCapitalModelCopyWith<MoneyCapitalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyCapitalModelCopyWith<$Res> {
  factory $MoneyCapitalModelCopyWith(
          MoneyCapitalModel value, $Res Function(MoneyCapitalModel) then) =
      _$MoneyCapitalModelCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      num value,
      DateTime time,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'company_name') String? companyName});
}

/// @nodoc
class _$MoneyCapitalModelCopyWithImpl<$Res>
    implements $MoneyCapitalModelCopyWith<$Res> {
  _$MoneyCapitalModelCopyWithImpl(this._value, this._then);

  final MoneyCapitalModel _value;
  // ignore: unused_field
  final $Res Function(MoneyCapitalModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? value = freezed,
    Object? time = freezed,
    Object? userName = freezed,
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
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
abstract class _$$_MoneyCapitalModelCopyWith<$Res>
    implements $MoneyCapitalModelCopyWith<$Res> {
  factory _$$_MoneyCapitalModelCopyWith(_$_MoneyCapitalModel value,
          $Res Function(_$_MoneyCapitalModel) then) =
      __$$_MoneyCapitalModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      num value,
      DateTime time,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'company_name') String? companyName});
}

/// @nodoc
class __$$_MoneyCapitalModelCopyWithImpl<$Res>
    extends _$MoneyCapitalModelCopyWithImpl<$Res>
    implements _$$_MoneyCapitalModelCopyWith<$Res> {
  __$$_MoneyCapitalModelCopyWithImpl(
      _$_MoneyCapitalModel _value, $Res Function(_$_MoneyCapitalModel) _then)
      : super(_value, (v) => _then(v as _$_MoneyCapitalModel));

  @override
  _$_MoneyCapitalModel get _value => super._value as _$_MoneyCapitalModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? value = freezed,
    Object? time = freezed,
    Object? userName = freezed,
    Object? companyName = freezed,
  }) {
    return _then(_$_MoneyCapitalModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
class _$_MoneyCapitalModel implements _MoneyCapitalModel {
  const _$_MoneyCapitalModel(
      {this.id,
      required this.value,
      required this.time,
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(name: 'company_name') this.companyName});

  factory _$_MoneyCapitalModel.fromJson(Map<String, dynamic> json) =>
      _$$_MoneyCapitalModelFromJson(json);

  @override
  final int? id;
  @override
  final num value;
  @override
  final DateTime time;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  @JsonKey(name: 'company_name')
  final String? companyName;

  @override
  String toString() {
    return 'MoneyCapitalModel(id: $id, value: $value, time: $time, userName: $userName, companyName: $companyName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoneyCapitalModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.value, value) &&
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
      const DeepCollectionEquality().hash(time),
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(companyName));

  @JsonKey(ignore: true)
  @override
  _$$_MoneyCapitalModelCopyWith<_$_MoneyCapitalModel> get copyWith =>
      __$$_MoneyCapitalModelCopyWithImpl<_$_MoneyCapitalModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoneyCapitalModelToJson(
      this,
    );
  }
}

abstract class _MoneyCapitalModel implements MoneyCapitalModel {
  const factory _MoneyCapitalModel(
          {final int? id,
          required final num value,
          required final DateTime time,
          @JsonKey(name: 'user_name') final String? userName,
          @JsonKey(name: 'company_name') final String? companyName}) =
      _$_MoneyCapitalModel;

  factory _MoneyCapitalModel.fromJson(Map<String, dynamic> json) =
      _$_MoneyCapitalModel.fromJson;

  @override
  int? get id;
  @override
  num get value;
  @override
  DateTime get time;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  @JsonKey(name: 'company_name')
  String? get companyName;
  @override
  @JsonKey(ignore: true)
  _$$_MoneyCapitalModelCopyWith<_$_MoneyCapitalModel> get copyWith =>
      throw _privateConstructorUsedError;
}
