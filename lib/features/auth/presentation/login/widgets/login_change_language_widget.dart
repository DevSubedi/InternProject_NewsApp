import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/core/localization/bloc/localization_bloc.dart';
import 'package:news_app/l10n/app_localizations.dart';

class LoginChangeLanguageWidget extends StatelessWidget {
  LoginChangeLanguageWidget({super.key});

  final ValueNotifier<String> lang = ValueNotifier<String>(''); 
  final List<String> language = ['Nepali', 'English'];
  final List<String> localeCodes = ['ne', 'en'];

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    
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
              value: value, 
              items: [
                DropdownMenuItem(
                  value: 'ne',
                  child: TextWidget(word: language[0]),
                ),
                DropdownMenuItem(
                  value: 'en', 
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
