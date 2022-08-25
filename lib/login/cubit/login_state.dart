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

class LoginState extends Equatable {
  final UserModel? user;
  final String token;
  final String message;

  final LoginStatus status;
  final LoginAction action;

  const LoginState(
      {this.user,
      this.token = '',
      this.message = '',
      this.action = LoginAction.none,
      this.status = LoginStatus.initial});

  LoginState copyWith({
    UserModel? user,
    String? token,
    String? message,
    LoginAction? action,
    LoginStatus? status,
  }) =>
      LoginState(
        user: user ?? this.user,
        token: token ?? this.token,
        message: message ?? this.message,
        action: action ?? this.action,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [user, token, message, action, status];
}
