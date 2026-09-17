import 'package:flutter/material.dart';
import 'package:noteapp/core/constant/app_color.dart';
import 'package:noteapp/core/localization/app_strings.dart';
import 'package:noteapp/core/routes/appRoutes.dart';

class HomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor:
          Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      leading: PopupMenuButton<String>(
        icon: Icon(
          Icons.menu,
          color: isDark
              ? AppColors.dr
              : AppColors.icon,
          size: 30,
        ),
        color: isDark
            ? const Color(0xFF202124)
            : AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onSelected: (value) {
          switch (value) {
            case "notes":
              break;

            case "settings":
              Navigator.pushNamed(
                context,
                Approutes.setting,
              );
              break;

            case "about":
              showAboutDialog(
                context: context,
                applicationName:
                    AppStrings.tr("noteapp"),
                applicationVersion: "1.0.0",
                applicationIcon: const Icon(
                  Icons.sticky_note_2,
                ),
                applicationLegalese:
                    AppStrings.tr(
                  "about_description",
                ),
                children: [
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.tr("developer"),
                  ),
                  Text(
                    AppStrings.tr("rights"),
                  ),
                ],
              );
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "notes",
            child: Row(
              children: [
                const Icon(
                  Icons.notes_outlined,
                ),
                const SizedBox(width: 12),
                Text(
                  AppStrings.tr("all_notes"),
                ),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: "settings",
            child: Row(
              children: [
                const Icon(
                  Icons.settings_outlined,
                ),
                const SizedBox(width: 12),
                Text(
                  AppStrings.tr("settings"),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: "about",
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                ),
                const SizedBox(width: 12),
                Text(
                  AppStrings.tr("about"),
                ),
              ],
            ),
          ),
        ],
      ),
      title: Text(
        AppStrings.tr("all_notes"),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: isDark
              ? AppColors.dr
              : AppColors.title,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              Approutes.search,
            );
          },
          icon: Icon(
            Icons.search,
            color: isDark
                ? AppColors.dr
                : AppColors.icon,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.grid_view_outlined,
            color: isDark
                ? AppColors.dr
                : AppColors.icon,
            size: 30,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}