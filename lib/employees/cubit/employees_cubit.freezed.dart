// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'employees_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EmployeesState {
  UserModel? get user => throw _privateConstructorUsedError;
  List<UserModel> get list => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  EmployeeAction get action => throw _privateConstructorUsedError;
  EmployeeStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmployeesStateCopyWith<EmployeesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeesStateCopyWith<$Res> {
  factory $EmployeesStateCopyWith(
          EmployeesState value, $Res Function(EmployeesState) then) =
      _$EmployeesStateCopyWithImpl<$Res>;
  $Res call(
      {UserModel? user,
      List<UserModel> list,
      String message,
      EmployeeAction action,
      EmployeeStatus status});

  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$EmployeesStateCopyWithImpl<$Res>
    implements $EmployeesStateCopyWith<$Res> {
  _$EmployeesStateCopyWithImpl(this._value, this._then);

  final EmployeesState _value;
  // ignore: unused_field
  final $Res Function(EmployeesState) _then;

  @override
  $Res call({
    Object? user = freezed,
    Object? list = freezed,
    Object? message = freezed,
    Object? action = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      list: list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as EmployeeAction,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EmployeeStatus,
    ));
  }

  @override
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$$_EmployeesStateCopyWith<$Res>
    implements $EmployeesStateCopyWith<$Res> {
  factory _$$_EmployeesStateCopyWith(
          _$_EmployeesState value, $Res Function(_$_EmployeesState) then) =
      __$$_EmployeesStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {UserModel? user,
      List<UserModel> list,
      String message,
      EmployeeAction action,
      EmployeeStatus status});

  @override
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_EmployeesStateCopyWithImpl<$Res>
    extends _$EmployeesStateCopyWithImpl<$Res>
    implements _$$_EmployeesStateCopyWith<$Res> {
  __$$_EmployeesStateCopyWithImpl(
      _$_EmployeesState _value, $Res Function(_$_EmployeesState) _then)
      : super(_value, (v) => _then(v as _$_EmployeesState));

  @override
  _$_EmployeesState get _value => super._value as _$_EmployeesState;

  @override
  $Res call({
    Object? user = freezed,
    Object? list = freezed,
    Object? message = freezed,
    Object? action = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_EmployeesState(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      list: list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as EmployeeAction,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EmployeeStatus,
    ));
  }
}

/// @nodoc

class _$_EmployeesState implements _EmployeesState {
  const _$_EmployeesState(
      {this.user,
      final List<UserModel> list = const [],
      this.message = '',
      this.action = EmployeeAction.none,
      this.status = EmployeeStatus.initial})
      : _list = list;

  @override
  final UserModel? user;
  final List<UserModel> _list;
  @override
  @JsonKey()
  List<UserModel> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final EmployeeAction action;
  @override
  @JsonKey()
  final EmployeeStatus status;

  @override
  String toString() {
    return 'EmployeesState(user: $user, list: $list, message: $message, action: $action, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EmployeesState &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.action, action) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(action),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_EmployeesStateCopyWith<_$_EmployeesState> get copyWith =>
      __$$_EmployeesStateCopyWithImpl<_$_EmployeesState>(this, _$identity);
}

abstract class _EmployeesState implements EmployeesState {
  const factory _EmployeesState(
      {final UserModel? user,
      final List<UserModel> list,
      final String message,
      final EmployeeAction action,
      final EmployeeStatus status}) = _$_EmployeesState;

  @override
  UserModel? get user;
  @override
  List<UserModel> get list;
  @override
  String get message;
  @override
  EmployeeAction get action;
  @override
  EmployeeStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_EmployeesStateCopyWith<_$_EmployeesState> get copyWith =>
      throw _privateConstructorUsedError;
}
