import 'package:flutter/material.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';

class LoginCheckBoxWidget extends StatelessWidget {
  final bool isChecked;
  final String title;
  final ValueChanged<bool?> onChanged;
  const LoginCheckBoxWidget({
    super.key,
    this.isChecked = false,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: isChecked, onChanged: onChanged),
        TextWidget(word: title),
      ],
    );
  }
}
