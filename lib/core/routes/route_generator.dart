import 'package:flutter/material.dart';
import 'package:noteapp/core/routes/appRoutes.dart';
import 'package:noteapp/features/addNote/presentation/pages/add_note.dart';
import 'package:noteapp/features/language/presentation/language_screen.dart';
import 'package:noteapp/features/notes/presentation/pages/home_screen.dart';
import 'package:noteapp/features/pinscreen/presentation/PinOptionsScreen.dart';
import 'package:noteapp/features/pinscreen/presentation/PinScreen.dart';
import 'package:noteapp/features/search/presentation/search_screen.dart';
import 'package:noteapp/features/setting/presentation/setting_screen.dart';
import 'package:noteapp/features/splashScreen/presentation/splach_screen.dart';
import 'package:noteapp/features/theme/presentation/theam_screen.dart';
import 'package:noteapp/model/pin_mode.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Approutes.splach:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case Approutes.AddNote:
        return MaterialPageRoute(
          builder: (_) => const AddNoteScreen(),
        );

      case Approutes.search:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );

      case Approutes.setting:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );

      case Approutes.lnguage:
        return MaterialPageRoute(
          builder: (_) => const LanguageScreen(),
        );

      case Approutes.theam:
        return MaterialPageRoute(
          builder: (_) => const TheamScreen(),
        );

      case Approutes.PIN:
        return MaterialPageRoute(
          builder: (_) => const PinScreen(
            mode: PinMode.create,
          ),
        );

      case Approutes.option:
        return MaterialPageRoute(
          builder: (_) => const PinOptionsScreen(),
        );
    }

    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
    );
  }
}