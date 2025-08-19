import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/l10n/app_localizations.dart';

class SignUpHeaderWidget extends StatelessWidget {
  const SignUpHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Container(
      child: Column(
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
            word: l10.signupText1,
            size: 20,
            textColor: Color(0xFF4E4B66),
          ),
        ],
      ),
    );
  }
}
