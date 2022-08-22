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
  }) : super(LoginInitial());

  Future loginUser(UserModel user) async {
    emit(LoginInProgress());
    var response = await accountingRepository.loginUser(user);
    if (response.status) {
      log.d('Token: ${response.data}');
      cachedRepository.token = response.data;
      emit(LoginSuccess(response.data as String, response.message));
    } else {
      emit(LoginFailure(response.message));
    }
  }
}
