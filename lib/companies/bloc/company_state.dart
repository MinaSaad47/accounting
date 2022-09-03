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

@freezed
class CompanyState with _$CompanyState {
  const factory CompanyState ({
    @Default([]) List<CompanyModel> list,
    @Default(null) CompanyModel? selected,
    @Default(CompanyStatus.initial) CompanyStatus status,
    @Default(CompanyAction.none) CompanyAction action,
    @Default('') message,
  }) = _CompanyState;
}