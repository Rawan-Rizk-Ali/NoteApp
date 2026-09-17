import 'package:flutter/material.dart';
import 'package:noteapp/core/localization/app_strings.dart';
import 'package:noteapp/features/pinscreen/presentation/PinScreen.dart';
import 'package:noteapp/model/pin_mode.dart';

class PinOptionsScreen extends StatelessWidget {
  const PinOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.tr("pin_settings")),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: Text(AppStrings.tr("create_pin")),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PinScreen(
                    mode: PinMode.create,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(AppStrings.tr("change_pin")),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PinScreen(
                    mode: PinMode.change,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: Text(AppStrings.tr("delete_pin")),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PinScreen(
                    mode: PinMode.delete,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}