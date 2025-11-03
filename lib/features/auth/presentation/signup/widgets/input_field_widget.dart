import 'package:flutter/material.dart';

// class InputField extends StatelessWidget {
//   final String label;
//   final TextInputType inputType;
//   final bool obscureText;
//   final ValueChanged<String> onChanged;
//   final String? errorText;

//   const InputField({
//     super.key,
//     required this.label,
//     this.inputType = TextInputType.text,
//     this.obscureText = false,
//     required this.onChanged,
//     this.errorText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       keyboardType: inputType,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         errorText: errorText?.isNotEmpty == true ? errorText : null,
//         border: const OutlineInputBorder(),
//       ),
//       onChanged: onChanged,
//     );
//   }
// }


class InputField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final bool obscureText;
  final TextInputType inputType;
  final bool enabled;
  final String? errorText;
  final Function(String)? onChanged;

  const InputField({
    super.key,
    required this.label,
    this.initialValue,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.enabled = true,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        // ),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: inputType,
          enabled: enabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
