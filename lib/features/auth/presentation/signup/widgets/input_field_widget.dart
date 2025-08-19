import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const InputField({
    super.key,
    required this.label,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorText?.isNotEmpty == true ? errorText : null,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
