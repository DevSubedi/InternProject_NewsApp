import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';
import 'package:news_app/features/localization/presentation/bloc/localization_bloc.dart';
import 'package:news_app/l10n/app_localizations.dart';

class LoginChangeLanguageWidget extends StatelessWidget {
  LoginChangeLanguageWidget({super.key});

  final ValueNotifier<String> lang = ValueNotifier<String>(''); // ✅ good
  final List<String> language = ['Nepali', 'English'];
  final List<String> localeCodes = ['ne', 'en'];

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    // ✅ Set the initial selected value only once
    lang.value = lang.value.isEmpty
        ? Localizations.localeOf(context).languageCode
        : lang.value;

    return Row(
      children: [
        TextWidget(word: l10.changeLanguage),
        const SizedBox(width: 10),
        ValueListenableBuilder(
          valueListenable: lang,
          builder: (context, value, child) {
            return DropdownButton<String>(
              value: value, // ✅ shows selected value near arrow
              items: [
                DropdownMenuItem(
                  value: 'ne', // ✅ CORRECT VALUE
                  child: TextWidget(word: language[0]),
                ),
                DropdownMenuItem(
                  value: 'en', // ✅ CORRECT VALUE
                  child: TextWidget(word: language[1]),
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  lang.value = newValue;
                  context.read<LocalizationBloc>().add(
                    ChangeLocaleEvent(Locale(newValue)),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
