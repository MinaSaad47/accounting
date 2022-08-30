part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure,
}

enum LoginAction {
  none,
  login,
  get,
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    UserModel? user,
    @Default('') String token,
    @Default('') String message,
    @Default(LoginAction.none) LoginAction action,
    @Default(LoginStatus.initial) LoginStatus status,
  }) = _LoginState;
}
