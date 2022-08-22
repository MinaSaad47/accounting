part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final String token, message;

  const LoginSuccess(this.token, this.message);

  @override
  List<Object?> get props => [token, message];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class LoginInProgress extends LoginState {
  @override
  List<Object?> get props => [];
}
