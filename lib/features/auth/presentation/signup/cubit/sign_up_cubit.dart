import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/common/widgets/show_toast_widget.dart';
import 'package:news_app/core/routing/navigation_service.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/auth/presentation/signup/cubit/sign_up_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(const SignupState());

  void getName(String name) => emit(state.copyWith(name: name));
  void getEmail(String email) => emit(state.copyWith(email: email));
  void getPassword(String password) => emit(state.copyWith(password: password));
  void getPhone(String phone) => emit(state.copyWith(phone: phone));
  void getGender(String gender) => emit(state.copyWith(gender: gender));
  void getAge(String age) => emit(state.copyWith(age: age));

  Future<void> signupPressed() async {
    String name = state.name.trim();
    String email = state.email.trim();
    String password = state.password.trim();
    String phone = state.phone.trim();
    String gender = state.gender;
    String age = state.age.trim();

    if (name.isEmpty) {
      emit(state.copyWith(nameStatus: "Please enter your name"));
      return;
    }
    if (email.isEmpty || !email.contains("@")) {
      emit(state.copyWith(emailStatus: "Enter a valid email"));
      return;
    }
    if (password.length < 6) {
      emit(state.copyWith(passwordStatus: "Password must be 6+ chars"));
      return;
    }
    if (phone.length != 10) {
      emit(state.copyWith(phoneStatus: "Enter valid 10-digit phone"));
      return;
    }
    if (int.tryParse(age) == null || int.parse(age) < 10) {
      emit(state.copyWith(ageStatus: "Enter valid age"));
      return;
    }

    emit(state.copyWith(signupStatus: "loading"));

    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
            "name": name,
            "email": email,
            "phone": phone,
            "gender": gender,
            "age": int.parse(age),
            "createdAt": DateTime.now(),
          });

      ShowToastWidget.show('User successfully registered!');
      emit(state.copyWith(signupStatus: "success"));

      // go back to login
      NavigationService.pushNamedReplacement(RouteName.login);
    } on FirebaseAuthException catch (e) {
      log("Signup error: ${e.message}");
      ShowToastWidget.show(e.message ?? "Signup Failed");

      emit(state.copyWith(signupStatus: "error"));
    } catch (e) {
      log("Unexpected error: $e");

      ShowToastWidget.show('$e' ?? "Unexpected error occurred");

      emit(state.copyWith(signupStatus: "error"));
    }
  }
}
