import 'package:flutter/material.dart';
import 'package:noteapp/core/constant/app_color.dart';
import 'package:noteapp/core/localization/app_strings.dart';
import 'package:noteapp/core/routes/appRoutes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.icon,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.tr("settings"),
          style: TextStyle(
            color: isDark ? AppColors.dr : AppColors.title,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _settingTile(
              context,
              isDark: isDark,
              icon: Icons.language,
              title: AppStrings.tr("language"),
              subtitle: AppStrings.tr("english"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Approutes.lnguage,
                );
              },
            ),

            const SizedBox(height: 15),

            _settingTile(
              context,
              isDark: isDark,
              icon: Icons.palette_outlined,
              title: AppStrings.tr("theme"),
              subtitle: AppStrings.tr("light"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Approutes.theam,
                );
              },
            ),

            const SizedBox(height: 15),

            _settingTile(
              context,
              isDark: isDark,
              icon: Icons.lock_outline,
              title: AppStrings.tr("security"),
              subtitle: AppStrings.tr("change_pin"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Approutes.option,
                );
              },
            ),

            const SizedBox(height: 15),

            _settingTile(
              context,
              isDark: isDark,
              icon: Icons.backup_outlined,
              title: AppStrings.tr("backup_restore"),
              subtitle: "",
              onTap: () {},
            ),

            const SizedBox(height: 15),

            _settingTile(
              context,
              isDark: isDark,
              icon: Icons.info_outline,
              title: AppStrings.tr("about_noteapp"),
              subtitle: "",
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: AppStrings.tr("noteapp"),
                  applicationVersion: "1.0.0",
                  applicationIcon: const Icon(
                    Icons.sticky_note_2,
                    color: AppColors.primary,
                  ),
                  applicationLegalese:
                  AppStrings.tr("developed_with_flutter"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingTile(
      BuildContext context, {
        required bool isDark,
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF2A2B2F)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? AppColors.dr
                : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 26,
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.dr
                          : AppColors.title,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.dr
                              : AppColors.subtitle,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: isDark
                  ? AppColors.dr
                  : AppColors.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}