// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'funder_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FunderState {
  List<FunderModel> get list => throw _privateConstructorUsedError;
  FunderStatus get status => throw _privateConstructorUsedError;
  FunderAction get action => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FunderStateCopyWith<FunderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FunderStateCopyWith<$Res> {
  factory $FunderStateCopyWith(
          FunderState value, $Res Function(FunderState) then) =
      _$FunderStateCopyWithImpl<$Res>;
  $Res call(
      {List<FunderModel> list,
      FunderStatus status,
      FunderAction action,
      String message});
}

/// @nodoc
class _$FunderStateCopyWithImpl<$Res> implements $FunderStateCopyWith<$Res> {
  _$FunderStateCopyWithImpl(this._value, this._then);

  final FunderState _value;
  // ignore: unused_field
  final $Res Function(FunderState) _then;

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
              as List<FunderModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FunderStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as FunderAction,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_FunderStateCopyWith<$Res>
    implements $FunderStateCopyWith<$Res> {
  factory _$$_FunderStateCopyWith(
          _$_FunderState value, $Res Function(_$_FunderState) then) =
      __$$_FunderStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<FunderModel> list,
      FunderStatus status,
      FunderAction action,
      String message});
}

/// @nodoc
class __$$_FunderStateCopyWithImpl<$Res> extends _$FunderStateCopyWithImpl<$Res>
    implements _$$_FunderStateCopyWith<$Res> {
  __$$_FunderStateCopyWithImpl(
      _$_FunderState _value, $Res Function(_$_FunderState) _then)
      : super(_value, (v) => _then(v as _$_FunderState));

  @override
  _$_FunderState get _value => super._value as _$_FunderState;

  @override
  $Res call({
    Object? list = freezed,
    Object? status = freezed,
    Object? action = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_FunderState(
      list: list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<FunderModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FunderStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as FunderAction,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_FunderState extends _FunderState {
  const _$_FunderState(
      {final List<FunderModel> list = const [],
      this.status = FunderStatus.initial,
      this.action = FunderAction.none,
      this.message = ''})
      : _list = list,
        super._();

  final List<FunderModel> _list;
  @override
  @JsonKey()
  List<FunderModel> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final FunderStatus status;
  @override
  @JsonKey()
  final FunderAction action;
  @override
  @JsonKey()
  final String message;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FunderState &&
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
  _$$_FunderStateCopyWith<_$_FunderState> get copyWith =>
      __$$_FunderStateCopyWithImpl<_$_FunderState>(this, _$identity);
}

abstract class _FunderState extends FunderState {
  const factory _FunderState(
      {final List<FunderModel> list,
      final FunderStatus status,
      final FunderAction action,
      final String message}) = _$_FunderState;
  const _FunderState._() : super._();

  @override
  List<FunderModel> get list;
  @override
  FunderStatus get status;
  @override
  FunderAction get action;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_FunderStateCopyWith<_$_FunderState> get copyWith =>
      throw _privateConstructorUsedError;
}
