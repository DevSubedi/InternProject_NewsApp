import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String word;
  final double? size;
  final Color? textColor;
  final FontWeight? weight;
  const TextWidget({
    super.key,
    required this.word,
    this.size,
    this.textColor,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      word,
      style: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: size ?? 14,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
