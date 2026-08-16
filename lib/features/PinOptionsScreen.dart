import 'package:flutter/material.dart';
import '../model/pin_mode.dart';
import '../features/PinScreen.dart';


class PinOptionsScreen extends StatelessWidget {
  const PinOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PIN Settings"),
      ),
      body: ListView(
        children: [

          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text("Create PIN"),
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
            title: const Text("Change PIN",

            ),
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
            title: const Text("Delete PIN"),
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