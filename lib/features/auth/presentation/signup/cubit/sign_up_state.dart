import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final String name;
  final String nameStatus;

  final String email;
  final String emailStatus;

  final String password;
  final String passwordStatus;

  final String phone;
  final String phoneStatus;

  final String gender;

  final String age;
  final String ageStatus;

  final String statusMessage;
  final String signupStatus; // idle, loading, success, error

  const SignupState({
    this.name = '',
    this.nameStatus = '',
    this.email = '',
    this.emailStatus = '',
    this.password = '',
    this.passwordStatus = '',
    this.phone = '',
    this.phoneStatus = '',
    this.gender = 'Male',
    this.age = '',
    this.ageStatus = '',
    this.statusMessage = '',
    this.signupStatus = '',
  });

  SignupState copyWith({
    String? name,
    String? nameStatus,
    String? email,
    String? emailStatus,
    String? password,
    String? passwordStatus,
    String? phone,
    String? phoneStatus,
    String? gender,
    String? age,
    String? ageStatus,
    String? statusMessage,
    String? signupStatus,
  }) {
    return SignupState(
      name: name ?? this.name,
      nameStatus: nameStatus ?? this.nameStatus,
      email: email ?? this.email,
      emailStatus: emailStatus ?? this.emailStatus,
      password: password ?? this.password,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      phone: phone ?? this.phone,
      phoneStatus: phoneStatus ?? this.phoneStatus,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      ageStatus: ageStatus ?? this.ageStatus,
      statusMessage: statusMessage ?? this.statusMessage,
      signupStatus: signupStatus ?? this.signupStatus,
    );
  }

  @override
  List<Object?> get props => [
        name,
        nameStatus,
        email,
        emailStatus,
        password,
        passwordStatus,
        phone,
        phoneStatus,
        gender,
        age,
        ageStatus,
        statusMessage,
        signupStatus,
      ];
}
