// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'income_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IncomeState {
  List<IncomeModel> get list => throw _privateConstructorUsedError;
  IncomeStatus get status => throw _privateConstructorUsedError;
  IncomeAction get action => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IncomeStateCopyWith<IncomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeStateCopyWith<$Res> {
  factory $IncomeStateCopyWith(
          IncomeState value, $Res Function(IncomeState) then) =
      _$IncomeStateCopyWithImpl<$Res>;
  $Res call(
      {List<IncomeModel> list,
      IncomeStatus status,
      IncomeAction action,
      String message});
}

/// @nodoc
class _$IncomeStateCopyWithImpl<$Res> implements $IncomeStateCopyWith<$Res> {
  _$IncomeStateCopyWithImpl(this._value, this._then);

  final IncomeState _value;
  // ignore: unused_field
  final $Res Function(IncomeState) _then;

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
              as List<IncomeModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as IncomeStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as IncomeAction,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_IncomeStateCopyWith<$Res>
    implements $IncomeStateCopyWith<$Res> {
  factory _$$_IncomeStateCopyWith(
          _$_IncomeState value, $Res Function(_$_IncomeState) then) =
      __$$_IncomeStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<IncomeModel> list,
      IncomeStatus status,
      IncomeAction action,
      String message});
}

/// @nodoc
class __$$_IncomeStateCopyWithImpl<$Res> extends _$IncomeStateCopyWithImpl<$Res>
    implements _$$_IncomeStateCopyWith<$Res> {
  __$$_IncomeStateCopyWithImpl(
      _$_IncomeState _value, $Res Function(_$_IncomeState) _then)
      : super(_value, (v) => _then(v as _$_IncomeState));

  @override
  _$_IncomeState get _value => super._value as _$_IncomeState;

  @override
  $Res call({
    Object? list = freezed,
    Object? status = freezed,
    Object? action = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_IncomeState(
      list: list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<IncomeModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as IncomeStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as IncomeAction,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_IncomeState extends _IncomeState {
  const _$_IncomeState(
      {final List<IncomeModel> list = const [],
      this.status = IncomeStatus.initial,
      this.action = IncomeAction.none,
      this.message = ''})
      : _list = list,
        super._();

  final List<IncomeModel> _list;
  @override
  @JsonKey()
  List<IncomeModel> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final IncomeStatus status;
  @override
  @JsonKey()
  final IncomeAction action;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'IncomeState(list: $list, status: $status, action: $action, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IncomeState &&
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
  _$$_IncomeStateCopyWith<_$_IncomeState> get copyWith =>
      __$$_IncomeStateCopyWithImpl<_$_IncomeState>(this, _$identity);
}

abstract class _IncomeState extends IncomeState {
  const factory _IncomeState(
      {final List<IncomeModel> list,
      final IncomeStatus status,
      final IncomeAction action,
      final String message}) = _$_IncomeState;
  const _IncomeState._() : super._();

  @override
  List<IncomeModel> get list;
  @override
  IncomeStatus get status;
  @override
  IncomeAction get action;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_IncomeStateCopyWith<_$_IncomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
