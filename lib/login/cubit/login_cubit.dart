import 'package:accounting/common/common.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AccountingRepository accountingRepository;
  final CachedRepository cachedRepository;
  LoginCubit({
    required this.accountingRepository,
    required this.cachedRepository,
  }) : super(const LoginState());

  Future loginUser(UserModel user) async {
    emit(state.copyWith(
      action: LoginAction.login,
      status: LoginStatus.loading,
    ));
    var response = await accountingRepository.loginUser(user);
    if (response.status) {
      log.d('Token: ${response.data}');
      cachedRepository.token = response.data;
      emit(state.copyWith(
          action: LoginAction.login,
          status: LoginStatus.success,
          message: response.message,
          token: response.data));
    } else {
      emit(state.copyWith(
        action: LoginAction.login,
        status: LoginStatus.failure,
        message: response.message,
      ));
    }
  }

  Future getCurrentUser() async {
    emit(state.copyWith(
      action: LoginAction.get,
      status: LoginStatus.loading,
    ));
    var response = await accountingRepository.getCurrentUser();
    if (response.status) {
      emit(state.copyWith(
        action: LoginAction.get,
        status: LoginStatus.success,
        user: response.data,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: LoginAction.get,
        status: LoginStatus.failure,
        message: response.message,
      ));
    }
  }
}
