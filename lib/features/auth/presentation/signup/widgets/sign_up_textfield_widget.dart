import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';

class SignUpTextfieldWidget extends StatelessWidget {
  final String title;

  const SignUpTextfieldWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextWidget(word: title, textColor: Color(0xFF4E4B66)),
            TextWidget(word: '*', textColor: Colors.red),
          ],
        ),
        4.verticalSpace,
      ],
    );
  }
}
