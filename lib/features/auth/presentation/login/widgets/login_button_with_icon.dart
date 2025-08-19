import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';

class LoginButtonWithIcon extends StatelessWidget {
  final IconData? icon;
  final String title;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? buttonBackground;
  final Function onPressed;

  const LoginButtonWithIcon({
    super.key,
    this.icon,
    required this.title,
    this.buttonWidth,
    this.buttonHeight,
    this.buttonBackground,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: Size(buttonWidth ?? 174.w, buttonHeight ?? 48.h),
        backgroundColor: Color(0xFFEEF1F4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24.h),
          10.horizontalSpace,
          TextWidget(word: title, size: 16.h),
        ],
      ),
    );
  }
}
