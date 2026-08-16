import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constant/app_color.dart';
import '../core/localization/app_strings.dart';
import '../provider/locale_provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = "English";

  final Map<String, String> languageCodes = {
    "English": "en",
    "العربية": "ar",
    "Français": "fr",
    "Español": "es",
    "Deutsch": "de",
    "Italiano": "it",
    "Português": "pt",
    "Türkçe": "tr",
    "Русский": "ru",
    "Українська": "uk",
    "Polski": "pl",
    "Nederlands": "nl",
    "Svenska": "sv",
    "Norsk": "no",
    "Dansk": "da",
    "Suomi": "fi",
    "Ελληνικά": "el",
    "עברית": "he",
    "हिन्दी": "hi",
    "বাংলা": "bn",
    "اردو": "ur",
    "فارسی": "fa",
    "中文 (简体)": "zh",
    "中文 (繁體)": "zh",
    "日本語": "ja",
    "한국어": "ko",
    "ไทย": "th",
    "Tiếng Việt": "vi",
    "Bahasa Indonesia": "id",
    "Bahasa Melayu": "ms",
  };

  final List<String> languages = [
    "English",
    "العربية",
    "Français",
    "Español",
    "Deutsch",
    "Italiano",
    "Português",
    "Türkçe",
    "Русский",
    "Українська",
    "Polski",
    "Nederlands",
    "Svenska",
    "Norsk",
    "Dansk",
    "Suomi",
    "Ελληνικά",
    "עברית",
    "हिन्दी",
    "বাংলা",
    "اردو",
    "فارسی",
    "中文 (简体)",
    "中文 (繁體)",
    "日本語",
    "한국어",
    "ไทย",
    "Tiếng Việt",
    "Bahasa Indonesia",
    "Bahasa Melayu",
  ];

  @override

    @override
    Widget build(BuildContext context) {
      final isDark =
          Theme.of(context).brightness == Brightness.dark;

      var selectedLanguage =
          context.watch<LocaleProvider>().selectedLanguage;

      return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? AppColors.dr : AppColors.icon,
          ),
        ),

        title: Text(AppStrings.tr("language"),
          style: TextStyle(
            color: isDark ? AppColors.dr : AppColors.title,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF2A2B2F)
                : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark
                  ? AppColors.dr
                  : AppColors.border,
            ),
          ),
          child: ListView.separated(
            itemCount: languages.length,
            padding: const EdgeInsets.symmetric(vertical: 8),

            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                height: 1,
                color: isDark
                    ? AppColors.dr
                    : AppColors.border,
              ),
            ),

            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                child: RadioListTile<String>(
                  value: languages[index],
                  groupValue: selectedLanguage,

                  controlAffinity:
                  ListTileControlAffinity.trailing,

                  activeColor: AppColors.primary,

                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12),

                  title: Text(
                    languages[index],
                    style: TextStyle(
                      fontSize: 20,
                      color: isDark
                          ? AppColors.dr
                          : AppColors.title,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                    });

                    context
                        .read<LocaleProvider>()
                        .changeLanguage(
                      languageCodes[value]!,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}