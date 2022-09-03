// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'company_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CompanyState {
  List<CompanyModel> get list => throw _privateConstructorUsedError;
  CompanyModel? get selected => throw _privateConstructorUsedError;
  CompanyStatus get status => throw _privateConstructorUsedError;
  CompanyAction get action => throw _privateConstructorUsedError;
  dynamic get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompanyStateCopyWith<CompanyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyStateCopyWith<$Res> {
  factory $CompanyStateCopyWith(
          CompanyState value, $Res Function(CompanyState) then) =
      _$CompanyStateCopyWithImpl<$Res>;
  $Res call(
      {List<CompanyModel> list,
      CompanyModel? selected,
      CompanyStatus status,
      CompanyAction action,
      dynamic message});

  $CompanyModelCopyWith<$Res>? get selected;
}

/// @nodoc
class _$CompanyStateCopyWithImpl<$Res> implements $CompanyStateCopyWith<$Res> {
  _$CompanyStateCopyWithImpl(this._value, this._then);

  final CompanyState _value;
  // ignore: unused_field
  final $Res Function(CompanyState) _then;

  @override
  $Res call({
    Object? list = freezed,
    Object? selected = freezed,
    Object? status = freezed,
    Object? action = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      list: list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<CompanyModel>,
      selected: selected == freezed
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as CompanyModel?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CompanyStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as CompanyAction,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }

  @override
  $CompanyModelCopyWith<$Res>? get selected {
    if (_value.selected == null) {
      return null;
    }

    return $CompanyModelCopyWith<$Res>(_value.selected!, (value) {
      return _then(_value.copyWith(selected: value));
    });
  }
}

/// @nodoc
abstract class _$$_CompanyStateCopyWith<$Res>
    implements $CompanyStateCopyWith<$Res> {
  factory _$$_CompanyStateCopyWith(
          _$_CompanyState value, $Res Function(_$_CompanyState) then) =
      __$$_CompanyStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<CompanyModel> list,
      CompanyModel? selected,
      CompanyStatus status,
      CompanyAction action,
      dynamic message});

  @override
  $CompanyModelCopyWith<$Res>? get selected;
}

/// @nodoc
class __$$_CompanyStateCopyWithImpl<$Res>
    extends _$CompanyStateCopyWithImpl<$Res>
    implements _$$_CompanyStateCopyWith<$Res> {
  __$$_CompanyStateCopyWithImpl(
      _$_CompanyState _value, $Res Function(_$_CompanyState) _then)
      : super(_value, (v) => _then(v as _$_CompanyState));

  @override
  _$_CompanyState get _value => super._value as _$_CompanyState;

  @override
  $Res call({
    Object? list = freezed,
    Object? selected = freezed,
    Object? status = freezed,
    Object? action = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_CompanyState(
      list: list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<CompanyModel>,
      selected: selected == freezed
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as CompanyModel?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CompanyStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as CompanyAction,
      message: message == freezed ? _value.message : message,
    ));
  }
}

/// @nodoc

class _$_CompanyState implements _CompanyState {
  const _$_CompanyState(
      {final List<CompanyModel> list = const [],
      this.selected = null,
      this.status = CompanyStatus.initial,
      this.action = CompanyAction.none,
      this.message = ''})
      : _list = list;

  final List<CompanyModel> _list;
  @override
  @JsonKey()
  List<CompanyModel> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final CompanyModel? selected;
  @override
  @JsonKey()
  final CompanyStatus status;
  @override
  @JsonKey()
  final CompanyAction action;
  @override
  @JsonKey()
  final dynamic message;

  @override
  String toString() {
    return 'CompanyState(list: $list, selected: $selected, status: $status, action: $action, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompanyState &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other.selected, selected) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.action, action) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(selected),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(action),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_CompanyStateCopyWith<_$_CompanyState> get copyWith =>
      __$$_CompanyStateCopyWithImpl<_$_CompanyState>(this, _$identity);
}

abstract class _CompanyState implements CompanyState {
  const factory _CompanyState(
      {final List<CompanyModel> list,
      final CompanyModel? selected,
      final CompanyStatus status,
      final CompanyAction action,
      final dynamic message}) = _$_CompanyState;

  @override
  List<CompanyModel> get list;
  @override
  CompanyModel? get selected;
  @override
  CompanyStatus get status;
  @override
  CompanyAction get action;
  @override
  dynamic get message;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyStateCopyWith<_$_CompanyState> get copyWith =>
      throw _privateConstructorUsedError;
}
