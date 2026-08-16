import 'package:flutter/material.dart';
import '../core/localization/app_strings.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  String get selectedLanguage {
    switch (_locale.languageCode) {
      case 'ar':
        return 'العربية';

      case 'fr':
        return 'Français';

      case 'es':
        return 'Español';

      case 'de':
        return 'Deutsch';

      default:
        return 'English';
    }
  }

  void changeLanguage(String code) {
    _locale = Locale(code);

    AppStrings.currentLanguage = code;

    notifyListeners();
  }
}