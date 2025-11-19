import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/core/routing/navigation_service.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:news_app/features/auth/presentation/login/cubit/login_state.dart';
import 'package:news_app/features/auth/presentation/login/widgets/login_button_widget.dart';
import 'package:news_app/features/auth/presentation/login/widgets/login_change_language_widget.dart';
import 'package:news_app/features/auth/presentation/login/widgets/login_check_box_widget.dart';

import 'package:news_app/features/auth/presentation/login/widgets/login_button_with_icon.dart';
import 'package:news_app/features/auth/presentation/login/widgets/login_text_field.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';

import 'package:news_app/l10n/app_localizations.dart';

class LoginScreenPart extends StatelessWidget {
  const LoginScreenPart({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
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

          return SizedBox(
            width: 400.h,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    word: l10.hello,
                    size: 48.h,
                    weight: FontWeight.bold,
                    textColor: Colors.blue,
                  ),

                  TextWidget(
                    word: l10.again,
                    size: 48.h,
                    textColor: Color(0xFF1877F2),
                    weight: FontWeight.bold,
                  ),
                  5.verticalSpace,
                  TextWidget(
                    word: l10.loginScreentext1,
                    size: 20,
                    textColor: Color(0xFF4E4B66),
                  ),
                  48.verticalSpace,

                  Column(
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            word: l10.email,
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
                        title: l10.email,
                        hintText: 'Enter Your ${l10.email}',
                        icon: false,
                        errorText: state.emailStatus.isNotEmpty
                            ? state.emailStatus
                            : null,
                      ),
                      16.verticalSpace,
                      Row(
                        children: [
                          TextWidget(
                            word: l10.password,
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
                        errorText: state.passwordStatus.isNotEmpty
                            ? state.passwordStatus
                            : null,
                      ),
                      LoginCheckBoxWidget(
                        isChecked: state.rememberMe,
                        title: l10.rememberMe,
                        onChanged: (value) {
                          context.read<LoginCubit>().toggleRememberMe(
                            value ?? false,
                          );
                        },
                      ),
                      16.verticalSpace,
                      LoginButton(
                        title: l10.login,

                        buttonHeight: 50,
                        buttonWidth: 379,
                        onPressed: (ctx) {
                          FocusScope.of(context).unfocus();
                          context.read<LoginCubit>().loginPressed(ctx);
                        },
                      ),
                      16.verticalSpace,
                      TextWidget(word: l10.loginScreentext2),
                      16.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoginButtonWithIcon(
                            title: 'Google',
                            icon: FontAwesomeIcons.google,
                            onPressed: () {
                              NavigationService.pushNamed(RouteName.newsPage);
                            },
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(word: l10.loginScreentext3),
                          TextButton(
                            onPressed: () {
                              NavigationService.pushNamed(RouteName.signUp);
                            },
                            child: TextWidget(
                              word: l10.signup,
                              weight: FontWeight.w500,
                              size: 18.h,
                              textColor: Color(0xFF1877F2),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [LoginChangeLanguageWidget()],
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
