import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:news_app/features/auth/presentation/login/widgets/login_screen_part.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context);
    final name = 'Dev Subedi';
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
