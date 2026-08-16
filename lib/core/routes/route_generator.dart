import 'package:flutter/material.dart';
import 'package:noteapp/core/routes/appRoutes.dart';
import 'package:noteapp/features/PinOptionsScreen.dart';
import 'package:noteapp/features/PinScreen.dart';
import 'package:noteapp/features/add_note.dart';

import 'package:noteapp/features/language_screen.dart';

import 'package:noteapp/features/setting_screen.dart';
import 'package:noteapp/features/theam_screen.dart';
import 'package:noteapp/model/pin_mode.dart';
import '../../features/home_screen.dart';
import '../../features/search_screen.dart';
import '../../features/splach_screen.dart';

class RouteGenerator {
  RouteGenerator._(); 


  static Route<dynamic>generateRoute(RouteSettings settings){
   switch(settings.name){
     case Approutes.splach:
       return MaterialPageRoute(builder: (_)=> const SplachScreen(),);

     case Approutes.AddNote:
       return MaterialPageRoute(builder: (_) => const AddNoteScreen(),);


     case Approutes.search:
       return MaterialPageRoute(
         builder: (_) => const SearchScreen(),
       );

     case Approutes.setting:
       return MaterialPageRoute(builder: (_) => const SettingsScreen(),);

     case Approutes.lnguage :
       return MaterialPageRoute(builder: (_) => const LanguageScreen(),);

     case Approutes.theam:
       return MaterialPageRoute(builder: (_)=> const TheamScreen(),);

     case Approutes.PIN:
       return MaterialPageRoute(builder: (_)=> const PinScreen(mode: PinMode.create),);


     case Approutes.option:
       return MaterialPageRoute(builder: (_)=> const PinOptionsScreen(),);


   }

   return MaterialPageRoute(
     builder: (_) => const HomeScreen(),
   );
  }

}