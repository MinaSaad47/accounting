// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expense_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ExpenseState {
  List<ExpenseModel> get list => throw _privateConstructorUsedError;
  ExpenseStatus get status => throw _privateConstructorUsedError;
  ExpenseAction get action => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpenseStateCopyWith<ExpenseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseStateCopyWith<$Res> {
  factory $ExpenseStateCopyWith(
          ExpenseState value, $Res Function(ExpenseState) then) =
      _$ExpenseStateCopyWithImpl<$Res>;
  $Res call(
      {List<ExpenseModel> list,
      ExpenseStatus status,
      ExpenseAction action,
      String message});
}

/// @nodoc
class _$ExpenseStateCopyWithImpl<$Res> implements $ExpenseStateCopyWith<$Res> {
  _$ExpenseStateCopyWithImpl(this._value, this._then);

  final ExpenseState _value;
  // ignore: unused_field
  final $Res Function(ExpenseState) _then;

  @override
  $Res call({
    Object? list = freezed,
    Object? status = freezed,
    Object? action = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      list: list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExpenseStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ExpenseAction,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ExpenseStateCopyWith<$Res>
    implements $ExpenseStateCopyWith<$Res> {
  factory _$$_ExpenseStateCopyWith(
          _$_ExpenseState value, $Res Function(_$_ExpenseState) then) =
      __$$_ExpenseStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<ExpenseModel> list,
      ExpenseStatus status,
      ExpenseAction action,
      String message});
}

/// @nodoc
class __$$_ExpenseStateCopyWithImpl<$Res>
    extends _$ExpenseStateCopyWithImpl<$Res>
    implements _$$_ExpenseStateCopyWith<$Res> {
  __$$_ExpenseStateCopyWithImpl(
      _$_ExpenseState _value, $Res Function(_$_ExpenseState) _then)
      : super(_value, (v) => _then(v as _$_ExpenseState));

  @override
  _$_ExpenseState get _value => super._value as _$_ExpenseState;

  @override
  $Res call({
    Object? list = freezed,
    Object? status = freezed,
    Object? action = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_ExpenseState(
      list: list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExpenseStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ExpenseAction,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ExpenseState extends _ExpenseState {
  const _$_ExpenseState(
      {final List<ExpenseModel> list = const [],
      this.status = ExpenseStatus.initial,
      this.action = ExpenseAction.none,
      this.message = ''})
      : _list = list,
        super._();

  final List<ExpenseModel> _list;
  @override
  @JsonKey()
  List<ExpenseModel> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final ExpenseStatus status;
  @override
  @JsonKey()
  final ExpenseAction action;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'ExpenseState(list: $list, status: $status, action: $action, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpenseState &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.action, action) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(action),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_ExpenseStateCopyWith<_$_ExpenseState> get copyWith =>
      __$$_ExpenseStateCopyWithImpl<_$_ExpenseState>(this, _$identity);
}

abstract class _ExpenseState extends ExpenseState {
  const factory _ExpenseState(
      {final List<ExpenseModel> list,
      final ExpenseStatus status,
      final ExpenseAction action,
      final String message}) = _$_ExpenseState;
  const _ExpenseState._() : super._();

  @override
  List<ExpenseModel> get list;
  @override
  ExpenseStatus get status;
  @override
  ExpenseAction get action;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_ExpenseStateCopyWith<_$_ExpenseState> get copyWith =>
      throw _privateConstructorUsedError;
}
