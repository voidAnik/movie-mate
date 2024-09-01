import 'package:flutter/material.dart';

// for demo purposes using single language file but we can add more language
enum Language {
  english,
}

extension LanguageExtension on Language {
  String get code {
    switch (this) {
      case Language.english:
        return 'en';
      default:
        return 'en';
    }
  }

  Locale get locale {
    switch (this) {
      case Language.english:
        return AppLanguage.english;
      default:
        return AppLanguage.english;
    }
  }

  String get text {
    switch (this) {
      case Language.english:
        return 'English';
      default:
        return 'English';
    }
  }
}

class AppLanguage {
  static final all = [
    const Locale('en'),
  ];
  static const path = 'assets/languages';
  static const english = Locale('en', '');
  static const englishCode = 'en';
}

/*
#? flutter pub run easy_localization:generate -S assets/language -f keys -O lib/core/language/generated -o locale_keys.g.dart

#? flutter pub run easy_localization:generate

#? flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart
*/
