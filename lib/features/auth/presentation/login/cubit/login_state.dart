import 'package:equatable/equatable.dart';

// class LoginState extends Equatable {
//   final String email;
//   final String emailStatus;
//   final String password;
//   final String passwordStatus;
//   final bool rememberMe;
//   final String statusMessage;
//   final String loginStatus;
//   const LoginState({
//     this.email = '',
//     this.emailStatus = '',
//     this.passwordStatus = '',

//     this.password = '',
//     this.statusMessage = '',
//     this.loginStatus = '',
//     this.rememberMe = false,
//   });

//   LoginState copyWith({
//     String? email,
//     String? password,
//     bool? rememberMe,
//     String? statusMessage,
//     String? loginStatus,
//     String? emailStatus,
//     String? passwordStatus,
//   }) {
//     return LoginState(
//       email: email ?? this.email,
//       emailStatus: emailStatus ?? this.emailStatus,
//       password: password ?? this.password,
//       passwordStatus: passwordStatus ?? this.passwordStatus,
//       rememberMe: rememberMe ?? this.rememberMe,
//       statusMessage: statusMessage ?? this.statusMessage,
//       loginStatus: loginStatus ?? this.loginStatus,
//     );
//   }

//   @override
//   // TODO: implement props
//   List<Object?> get props => [email, password, statusMessage, rememberMe];
// }

class LoginState extends Equatable {
  final String email;
  final String emailStatus;
  final String password;
  final String passwordStatus;
  final bool rememberMe;
  final String statusMessage;
  final String loginStatus;

  const LoginState({
    this.email = '',
    this.emailStatus = '',
    this.password = '',
    this.passwordStatus = '',
    this.rememberMe = false,
    this.statusMessage = '',
    this.loginStatus = '',
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    String? statusMessage,
    String? loginStatus,
    String? emailStatus,
    String? passwordStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      emailStatus: emailStatus ?? this.emailStatus,
      password: password ?? this.password,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      rememberMe: rememberMe ?? this.rememberMe,
      statusMessage: statusMessage ?? this.statusMessage,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    emailStatus,
    passwordStatus,
    statusMessage,
    loginStatus,
    rememberMe,
  ];
}
