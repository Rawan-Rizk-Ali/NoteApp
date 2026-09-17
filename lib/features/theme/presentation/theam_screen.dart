import 'package:flutter/material.dart';
import 'package:noteapp/provider/theam_provider.dart';
import 'package:provider/provider.dart';

class TheamScreen extends StatelessWidget {
  const TheamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Theme',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            _ThemeOption(
              title: 'Light',
              subtitle: 'Default theme',
              theme: AppThemeMode.light,
              groupValue: provider.theme,
              previewBackground: Colors.white,
              previewColor: const Color(0xFFEDEAE3),
              onTap: () {
                provider.setTheme(AppThemeMode.light);
              },
            ),
            const SizedBox(height: 16),
            _ThemeOption(
              title: 'Dark',
              subtitle: 'Easy on the eyes',
              theme: AppThemeMode.dark,
              groupValue: provider.theme,
              previewBackground: const Color(0xFF282828),
              previewColor: const Color(0xFF454545),
              onTap: () {
                provider.setTheme(AppThemeMode.dark);
              },
            ),
            const SizedBox(height: 16),
            _ThemeOption(
              title: 'Sepia',
              subtitle: 'Warm and soft',
              theme: AppThemeMode.sepia,
              groupValue: provider.theme,
              previewBackground: const Color(0xFFF7EED8),
              previewColor: const Color(0xFFE9DFC5),
              onTap: () {
                provider.setTheme(AppThemeMode.sepia);
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Text(
                'Theme will be applied automatically.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.color
                      ?.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final AppThemeMode theme;
  final AppThemeMode groupValue;
  final Color previewBackground;
  final Color previewColor;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    required this.subtitle,
    required this.theme,
    required this.groupValue,
    required this.previewBackground,
    required this.previewColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = theme == groupValue;

    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      width: double.infinity,
      height:160,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context)
                  .dividerColor
                  .withOpacity(0.2),
          width: selected ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.04,
            ),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.color
                          ?.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 70,
              height: 86,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: previewBackground,
                borderRadius:
                    BorderRadius.circular(9),
                border: Border.all(
                  color:
                      Colors.black.withOpacity(0.06),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 9,
                    decoration: BoxDecoration(
                      color: previewColor,
                      borderRadius:
                          BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    height: 25,
                    decoration: BoxDecoration(
                      color: previewColor,
                      borderRadius:
                          BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration:
                              BoxDecoration(
                            color: previewColor,
                            borderRadius:
                                BorderRadius.circular(
                              5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration:
                              BoxDecoration(
                            color: previewColor,
                            borderRadius:
                                BorderRadius.circular(
                              5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Radio<AppThemeMode>(
              value: theme,
              groupValue: groupValue,
              onChanged: (_) {
                onTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}