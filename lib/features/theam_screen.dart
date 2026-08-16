import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theam_provider.dart';

class TheamScreen extends StatelessWidget {
  const TheamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          RadioListTile<AppThemeMode>(
            title: const Text("Light"),
            value: AppThemeMode.light,
            groupValue: provider.theme,
            onChanged: (value) {
              provider.setTheme(value!);
            },
          ),

          RadioListTile<AppThemeMode>(
            title: const Text("Dark"),
            value: AppThemeMode.dark,
            groupValue: provider.theme,
            onChanged: (value) {
              provider.setTheme(value!);
            },
          ),

          RadioListTile<AppThemeMode>(
            title: const Text("Sepia"),
            value: AppThemeMode.sepia,
            groupValue: provider.theme,
            onChanged: (value) {
              provider.setTheme(value!);
            },
          ),
        ],
      ),
    );
  }
}