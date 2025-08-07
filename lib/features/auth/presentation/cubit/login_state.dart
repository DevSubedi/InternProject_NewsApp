import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final String statusMessage;
  final String loginStatus;
  const LoginState({
    this.emailError,
    this.passwordError,
    this.email = '',
    this.password = '',
    this.statusMessage = '',
    this.loginStatus = '',
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    String? statusMessage,
    String? loginStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      statusMessage: statusMessage ?? this.statusMessage,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    email,
    password,
    emailError,
    passwordError,
    statusMessage,
  ];
}
