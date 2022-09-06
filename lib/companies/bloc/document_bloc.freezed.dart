// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'document_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DocumentState {
  List<DocumentModel> get list => throw _privateConstructorUsedError;
  DocumentStatus get status => throw _privateConstructorUsedError;
  DocumentAction get action => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DocumentStateCopyWith<DocumentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentStateCopyWith<$Res> {
  factory $DocumentStateCopyWith(
          DocumentState value, $Res Function(DocumentState) then) =
      _$DocumentStateCopyWithImpl<$Res>;
  $Res call(
      {List<DocumentModel> list,
      DocumentStatus status,
      DocumentAction action,
      String message});
}

/// @nodoc
class _$DocumentStateCopyWithImpl<$Res>
    implements $DocumentStateCopyWith<$Res> {
  _$DocumentStateCopyWithImpl(this._value, this._then);

  final DocumentState _value;
  // ignore: unused_field
  final $Res Function(DocumentState) _then;

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
              as List<DocumentModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DocumentStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as DocumentAction,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_DocumentStateCopyWith<$Res>
    implements $DocumentStateCopyWith<$Res> {
  factory _$$_DocumentStateCopyWith(
          _$_DocumentState value, $Res Function(_$_DocumentState) then) =
      __$$_DocumentStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<DocumentModel> list,
      DocumentStatus status,
      DocumentAction action,
      String message});
}

/// @nodoc
class __$$_DocumentStateCopyWithImpl<$Res>
    extends _$DocumentStateCopyWithImpl<$Res>
    implements _$$_DocumentStateCopyWith<$Res> {
  __$$_DocumentStateCopyWithImpl(
      _$_DocumentState _value, $Res Function(_$_DocumentState) _then)
      : super(_value, (v) => _then(v as _$_DocumentState));

  @override
  _$_DocumentState get _value => super._value as _$_DocumentState;

  @override
  $Res call({
    Object? list = freezed,
    Object? status = freezed,
    Object? action = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_DocumentState(
      list: list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<DocumentModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DocumentStatus,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as DocumentAction,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_DocumentState extends _DocumentState {
  const _$_DocumentState(
      {final List<DocumentModel> list = const [],
      this.status = DocumentStatus.initial,
      this.action = DocumentAction.none,
      this.message = ''})
      : _list = list,
        super._();

  final List<DocumentModel> _list;
  @override
  @JsonKey()
  List<DocumentModel> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final DocumentStatus status;
  @override
  @JsonKey()
  final DocumentAction action;
  @override
  @JsonKey()
  final String message;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DocumentState &&
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
  _$$_DocumentStateCopyWith<_$_DocumentState> get copyWith =>
      __$$_DocumentStateCopyWithImpl<_$_DocumentState>(this, _$identity);
}

abstract class _DocumentState extends DocumentState {
  const factory _DocumentState(
      {final List<DocumentModel> list,
      final DocumentStatus status,
      final DocumentAction action,
      final String message}) = _$_DocumentState;
  const _DocumentState._() : super._();

  @override
  List<DocumentModel> get list;
  @override
  DocumentStatus get status;
  @override
  DocumentAction get action;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_DocumentStateCopyWith<_$_DocumentState> get copyWith =>
      throw _privateConstructorUsedError;
}
