import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(word: 'Hello', size: 48.h, weight: FontWeight.bold),
            5.verticalSpace,
            TextWidget(
              word: 'Again!',
              size: 48.h,
              textColor: Colors.blue,
              weight: FontWeight.bold,
            ),
            5.verticalSpace,
            TextWidget(
              word: "Welcome back you've \n been missed",
              size: 20,
              textColor: Color(0xFF4E4B66),
            ),
            48.verticalSpace,
          ],
        ),
      ),
    );
  }
}
