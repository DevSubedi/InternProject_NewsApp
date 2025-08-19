import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/routing/navigation_service.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/auth/presentation/login/widgets/login_button_widget.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/features/auth/presentation/signup/cubit/sign_up_cubit.dart';
import 'package:news_app/features/auth/presentation/signup/cubit/sign_up_state.dart';
import 'package:news_app/features/auth/presentation/signup/widgets/input_field_widget.dart';
import 'package:news_app/features/auth/presentation/signup/widgets/sign_up_header_widget.dart';
import 'package:news_app/features/auth/presentation/signup/widgets/sign_up_textfield_widget.dart';
import 'package:news_app/l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SignUpHeaderWidget(),

                      48.verticalSpace,
                      Column(
                        children: [
                          SignUpTextfieldWidget(title: l10.name),
                          InputField(
                            label: "Name",
                            onChanged: (v) =>
                                context.read<SignupCubit>().getName(v),
                            errorText: state.nameStatus,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          SignUpTextfieldWidget(title: l10.email),
                          InputField(
                            label: "Email",
                            inputType: TextInputType.emailAddress,
                            onChanged: (v) =>
                                context.read<SignupCubit>().getEmail(v),
                            errorText: state.emailStatus,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          SignUpTextfieldWidget(title: l10.password),
                          InputField(
                            label: "Password",
                            obscureText: false,
                            onChanged: (v) =>
                                context.read<SignupCubit>().getPassword(v),
                            errorText: state.passwordStatus,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          SignUpTextfieldWidget(title: l10.phoneNo),
                          InputField(
                            label: "Phone (Nepal)",
                            inputType: TextInputType.phone,
                            onChanged: (v) =>
                                context.read<SignupCubit>().getPhone(v),
                            errorText: state.phoneStatus,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          SignUpTextfieldWidget(title: l10.gender),
                          DropdownButtonFormField<String>(
                            value: state.gender,
                            items: [l10.male, l10.female, l10.others]
                                .map(
                                  (g) => DropdownMenuItem(
                                    value: g,
                                    child: Text(g),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) => context
                                .read<SignupCubit>()
                                .getGender(v ?? l10.male),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          SignUpTextfieldWidget(title: l10.age),
                          InputField(
                            label: "Age",
                            inputType: TextInputType.number,
                            onChanged: (v) =>
                                context.read<SignupCubit>().getAge(v),
                            errorText: state.ageStatus,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Center(
                        child: SizedBox(
                          width: 300.w,
                          height: 60.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.h),
                              ),
                            ),
                            onPressed: () {
                              context.read<SignupCubit>().signupPressed();
                            },
                            child: state.signupStatus == "loading"
                                ? const CircularProgressIndicator()
                                : const TextWidget(
                                    word: 'Signup',
                                    size: 18,
                                    textColor: Colors.white,
                                    weight: FontWeight.w600,
                                  ),
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(word: l10.signupText2),
                            TextButton(
                              onPressed: () {
                                NavigationService.pushNamed(RouteName.login);
                              },
                              child: TextWidget(
                                weight: FontWeight.w500,
                                size: 18.h,
                                word: l10.login,
                                textColor: Color(0xFF1877F2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
