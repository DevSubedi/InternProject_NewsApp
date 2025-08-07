import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/auth/presentation/cubit/login_state.dart';
import 'package:news_app/features/home/home_screen.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void getEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void getPassword(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> loginPressed(BuildContext context) async {
    log('${state.email}, ${state.password}');
    log('Email input raw: ${state.email}');
    log('Trimmed: ${state.email.trim()}');

    String email = state.email.trim();
    String password = state.password.trim();

    if (email.isEmpty || !email.contains('@')) {
      emit(state.copyWith(loginStatus: 'Please enter a valid email address'));
      return;
    }
    if (password.length < 6 || password.isEmpty) {
      emit(state.copyWith(loginStatus: 'Password must be of 6 characters'));
      return;
    }
    emit(state.copyWith(statusMessage: 'Validating login...'));
    // from here the firebase login part
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      log('Navigating to next page');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
      emit(state.copyWith(loginStatus: 'Login Sucessful!'));
    } on FirebaseAuthException catch (e) {
      log('${e.message}');
      emit(state.copyWith(loginStatus: '${e.message} : Login Failed!'));
    } catch (e) {
      log('problem is here');
      emit(state.copyWith(loginStatus: 'Unexpected Error occured: '));
    }
  }
}
