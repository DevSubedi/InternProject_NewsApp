import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';

class LoginButton extends StatelessWidget {
  final String title;

  final double? buttonHeight;
  final double? buttonWidth;
  final Color? buttonBackgroundColor;

  final void Function(BuildContext context) onPressed;
  const LoginButton({
    super.key,
    required this.title,

    required this.onPressed,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF1877F2),
        minimumSize: Size(buttonWidth ?? 379, buttonHeight ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
      ),

      onPressed: () {
        onPressed(context);
      },
      child: TextWidget(
        word: title,
        size: 16.h,
        weight: FontWeight.w900,
        textColor: Colors.white,
      ),
    );
  }
}
