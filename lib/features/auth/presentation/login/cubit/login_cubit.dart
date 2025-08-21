import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/core/routing/navigation_service.dart';
import 'package:news_app/features/auth/presentation/login/cubit/login_state.dart';

import '../../../../../core/routing/route_name.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void getEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void getPassword(String password) {
    emit(state.copyWith(password: password));
  } 

  Future<void> loginPressed(BuildContext context) async {
    // log('${state.email}, ${state.password}');
    // log('Email input raw: ${state.email}');
    // log('Trimmed: ${state.email.trim()}');

    String email = state.email.trim();
    String password = state.password.trim();

    if (email.isEmpty || !email.contains('@')) {
      emit(state.copyWith(emailStatus: 'Please enter a valid email address'));
      return;
    }
    if (password.length < 6 || password.isEmpty) {
      emit(state.copyWith(passwordStatus: 'Password must be of 6 characters'));
      return;
    }
    emit(state.copyWith(statusMessage: 'Validating login...'));
    // from here the firebase login part
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //Hive part
      var box = Hive.box('authBox');
      await box.put('isLoggedIn', true);
      await box.put('email', email);
      await box.put('password', password);

      emit(state.copyWith(loginStatus: 'Login Sucessful!'));

      NavigationService.pushNamedReplacement(RouteName.newsPage);
    } on FirebaseAuthException catch (e) {
      log('${e.message}');
      emit(state.copyWith(loginStatus: '${e.message} : Login Failed!'));
    } catch (e) {
      log('problem is here');
      log('$e');
      emit(state.copyWith(loginStatus: 'Unexpected Error occured: '));
    }
  }

  //hive for remember me
  void toggleRememberMe(bool value) => emit(state.copyWith(rememberMe: value));
}
