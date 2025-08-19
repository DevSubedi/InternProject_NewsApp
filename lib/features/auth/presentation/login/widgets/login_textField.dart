import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  final String title;
  final String hintText;
  final bool? icon;
  final Function(String)? onChanged;
  final String? errorText;

  LoginTextfield({
    super.key,
    required this.title,
    required this.hintText,
    this.icon = false,
    this.onChanged,
    this.errorText,
  });

  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    if (icon == false) {
      return TextFormField(
        onChanged: (value) => onChanged?.call(value),
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          border: OutlineInputBorder(),
        ),
      );
    } else {
      return ValueListenableBuilder<bool>(
        valueListenable: _obscurePassword,
        builder: (context, isObscure, _) {
          return TextFormField(
            onChanged: (value) => onChanged?.call(value),
            obscureText: isObscure,

            decoration: InputDecoration(
              errorText: errorText,
              hintText: hintText,

              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  _obscurePassword.value = !isObscure;
                },
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
              ),
            ),
          );
        },
      );
    }
  }
}
