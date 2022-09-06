part of 'funder_bloc.dart';

enum FunderStatus {
  initial,
  loading,
  success,
  failure,
}

enum FunderAction {
  none,
  get,
  create,
  delete,
}

@Freezed(toStringOverride: false)
class FunderState with _$FunderState {
  const FunderState._();
  @override
  String toString() {
    return '($action, $status)';
  }

  const factory FunderState({
    @Default([]) List<FunderModel> list,
    @Default(FunderStatus.initial) FunderStatus status,
    @Default(FunderAction.none) FunderAction action,
    @Default('') String message,
  }) = _FunderState;
}
