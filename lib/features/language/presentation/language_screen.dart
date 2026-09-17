import 'package:flutter/material.dart';
import 'package:noteapp/core/constant/app_color.dart';
import 'package:noteapp/core/localization/app_strings.dart';
import 'package:noteapp/provider/locale_provider.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  static const Map<String, String> languageCodes = {
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

  static const List<String> languages = [
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
  Widget build(BuildContext context) {
    final provider = context.watch<LocaleProvider>();

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark
                ? AppColors.dr
                : AppColors.icon,
          ),
        ),
        title: Text(
          AppStrings.tr("language"),
          style: TextStyle(
            color: isDark
                ? AppColors.dr
                : AppColors.title,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: languages.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final language = languages[index];
            final code = languageCodes[language]!;

            final selected =
                provider.selectedLanguage == language;

            return _LanguageOption(
              language: language,
              selected: selected,
              isDark: isDark,
              onTap: () {
                provider.changeLanguage(code);
              },
            );
          },
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final bool selected;
  final bool isDark;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.language,
    required this.selected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 72,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2A2B2F)
            : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected
              ? AppColors.primary
              : isDark
                  ? AppColors.dr.withOpacity(0.15)
                  : AppColors.border,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  language,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.dr
                        : AppColors.title,
                  ),
                ),
              ),
              Radio<String>(
                value: language,
                groupValue: selected
                    ? language
                    : null,
                activeColor: AppColors.primary,
                onChanged: (_) {
                  onTap();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}