part of 'income_bloc.dart';

enum IncomeStatus {
  initial,
  loading,
  success,
  failure,
}

enum IncomeAction {
  none,
  get,
  create,
  delete,
}

@Freezed(toStringOverride: false)
class IncomeState with _$IncomeState {
  const IncomeState._();
  @override
  String toString() {
    return '($action, $status)';
  }

  double get total => list.map((e) => e.value).fold(0.0, (p, c) => p + c);

  const factory IncomeState({
    @Default([]) List<IncomeModel> list,
    @Default(IncomeStatus.initial) IncomeStatus status,
    @Default(IncomeAction.none) IncomeAction action,
    @Default('') String message,
  }) = _IncomeState;
}
