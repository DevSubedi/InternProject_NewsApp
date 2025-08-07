import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:news_app/features/auth/presentation/cubit/login_state.dart';
import 'package:news_app/features/auth/presentation/widgets/login_checkBox_widget.dart';
import 'package:news_app/features/auth/presentation/widgets/login_button.dart';
import 'package:news_app/features/auth/presentation/widgets/login_button_with_icon.dart';
import 'package:news_app/features/auth/presentation/widgets/login_textField.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';

class LoginScreenPart extends StatelessWidget {
  const LoginScreenPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (prev, curr) =>
          prev.loginStatus != curr.loginStatus ||
          prev.statusMessage != curr.statusMessage,
      listener: (context, state) {
        if (state.statusMessage.isNotEmpty) {
          Fluttertoast.showToast(msg: state.statusMessage);
        }
        if (state.loginStatus.isNotEmpty) {
          Fluttertoast.showToast(msg: state.loginStatus);
        }
      },

      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          void handleEmailChange(String value) {
            context.read<LoginCubit>().getEmail(value);
          }

          void handlePasswordChange(String value) {
            context.read<LoginCubit>().getPassword(value);
          }

          return Container(
            width: 400.h,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    word: 'Hello',
                    size: 48.h,
                    weight: FontWeight.bold,
                  ),
                  TextWidget(
                    word: 'Again!',
                    size: 48.h,
                    textColor: Color(0xFF1877F2),
                    weight: FontWeight.bold,
                  ),
                  5.verticalSpace,
                  TextWidget(
                    word: "Welcome back you've \n been missed",
                    size: 20,
                    textColor: Color(0xFF4E4B66),
                  ),
                  48.verticalSpace,

                  Column(
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            word: 'Username',
                            textColor: Color(0xFF4E4B66),
                          ),
                          TextWidget(word: '*', textColor: Colors.red),
                        ],
                      ),
                      4.verticalSpace,
                      LoginTextfield(
                        onChanged: handleEmailChange,
                        // onChanged: (value) =>
                        //     context.read<LoginCubit>().getEmail(value),
                        title: 'UserName',
                        hintText: 'Enter Your Name',
                        icon: false,
                      ),
                      16.verticalSpace,
                      Row(
                        children: [
                          TextWidget(
                            word: 'Password',
                            textColor: Color(0xFF4E4B66),
                          ),
                          TextWidget(word: '*', textColor: Colors.red),
                        ],
                      ),
                      LoginTextfield(
                        onChanged: handlePasswordChange,
                        title: 'Password',
                        hintText: '*********',
                        icon: true,
                      ),
                      LoginCheckBoxWidget(
                        title: 'Remember me',
                        onChanged: () {},
                      ),
                      16.verticalSpace,
                      LoginButton(
                        title: 'Login',

                        buttonHeight: 50,
                        buttonWidth: 379,
                        onPressed: (ctx) {
                          log('button Pressed');
                          context.read<LoginCubit>().loginPressed(ctx);
                        },
                      ),
                      16.verticalSpace,
                      TextWidget(word: 'or continue with'),
                      16.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoginButtonWithIcon(
                            title: 'Google',
                            icon: FontAwesomeIcons.google,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(word: "Don't have an account?"),
                          TextButton(
                            onPressed: () {},
                            child: TextWidget(
                              word: 'Sign up',
                              textColor: Color(0xFF1877F2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
