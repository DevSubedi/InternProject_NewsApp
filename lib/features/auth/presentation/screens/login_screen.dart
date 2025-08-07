import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:news_app/features/auth/presentation/widgets/login_screen_part.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 24.h,
              left: 24.h,
              right: 24.h,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginScreenPart(),
            ),
          ),
        ),
      ),
    );
  }
}
