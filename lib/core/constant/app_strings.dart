class AppStrings {
  static String currentLanguage = "en";

  static final Map<String, Map<String, String>> translations = {
    "en": {
      "Language": "Language",
    },

    "ar": {
      "Language": "اللغة",
    },

    "fr": {
      "Language": "Langue",
    },

    "es": {
      "Language": "Idioma",
    },

    "de": {
      "Language": "Sprache",
    },
  };

  static String tr(String key) {
    return translations[currentLanguage]?[key] ?? key;
  }
}