import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:noteapp/provider/locale_provider.dart';
import 'package:noteapp/provider/theam_provider.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/appRoutes.dart';
import 'core/routes/route_generator.dart';
import 'core/theam/app_theam.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, child) {

        ThemeData currentTheme;

        switch (themeProvider.theme) {
          case AppThemeMode.light:
            currentTheme = AppTheme.lightTheme;
            break;

          case AppThemeMode.dark:
            currentTheme = AppTheme.darkTheme;
            break;

          case AppThemeMode.sepia:
            currentTheme = AppTheme.sepiaTheme;
            break;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: localeProvider.locale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
            Locale('fr'),
            Locale('es'),
            Locale('de'),
          ],

          theme: currentTheme.copyWith(
            textTheme: GoogleFonts.cormorantGaramondTextTheme(
              currentTheme.textTheme,
            ),
          ),

          initialRoute: Approutes.splach,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}