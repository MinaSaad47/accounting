part of 'company_bloc.dart';

enum CompanyAction {
  none,
  get,
  delete,
  save,
}

enum CompanyStatus {
  initial,
  loading,
  success,
  failure,
}

@Freezed(toStringOverride: false)
class CompanyState with _$CompanyState {
  const CompanyState._();
  @override
  String toString() {
    return '($action, $status)';
  }

  const factory CompanyState({
    @Default([]) List<CompanyModel> list,
    @Default(CompanyStatus.initial) CompanyStatus status,
    @Default(CompanyAction.none) CompanyAction action,
    @Default('') message,
  }) = _CompanyState;

}
