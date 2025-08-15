import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/theme/theme_cubit.dart';

class ColorModel {
  final Color lightModeColor;
  final Color darkModeColor;

  ColorModel({required this.lightModeColor, required this.darkModeColor});

  Color getColor(bool isDarkMode) =>
      isDarkMode ? darkModeColor : lightModeColor;
}

extension AppColorExtension on ColorModel {
  Color current(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;
    return getColor(isDark);
  }
}
