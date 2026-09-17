import 'package:flutter/material.dart';

import 'package:noteapp/core/constant/app_color.dart';
import 'package:noteapp/core/routes/appRoutes.dart';

class AddNoteFab extends StatelessWidget {
  const AddNoteFab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color:
                AppColors.primary.withOpacity(0.35),
            blurRadius: 20,
            spreadRadius: 6,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: isDark
            ? AppColors.dr
            : AppColors.primary,
        elevation: 0,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(
            context,
            Approutes.AddNote,
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: AppColors.icon,
        ),
      ),
    );
  }
}