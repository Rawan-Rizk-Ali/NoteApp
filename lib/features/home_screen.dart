import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/constant/app_color.dart';
import '../core/localization/app_strings.dart';
import '../core/routes/appRoutes.dart';
import '../model/note_model.dart';
import 'note_dateils_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        leading: PopupMenuButton<String>(
          icon: Icon(
            Icons.menu,
            color: isDark ? AppColors.dr : AppColors.icon,
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
                  applicationName: AppStrings.tr("noteapp"),
                  applicationVersion: "1.0.0",
                  applicationIcon: const Icon(
                    Icons.sticky_note_2,
                  ),
                  applicationLegalese:
                  AppStrings.tr("about_description"),
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
                  const Icon(Icons.notes_outlined),
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
                  const Icon(Icons.settings_outlined),
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
                  const Icon(Icons.info_outline),
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
            color: isDark ? AppColors.dr : AppColors.title,
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
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .orderBy(
          'isPinned',
          descending: true,
        )
            .orderBy(
          'createdAt',
          descending: true,
        )
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                AppStrings.tr("no_data"),
              ),
            );
          }

          final notes = snapshot.data!.docs
              .map(
                (doc) => NoteModel.fromFirestore(doc),
          )
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),

            itemCount: notes.length,

            itemBuilder: (context, index) {
              final note = notes[index];

              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),

                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteDetailsScreen(
                          note: note,
                        ),
                      ),
                    );
                  },

                  child: Container(
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: AppColors.noteColors[
                      note.colorIndex %
                          AppColors.noteColors.length],
                      borderRadius:
                      BorderRadius.circular(18),
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                note.title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight:
                                  FontWeight.w700,
                                  color:
                                  AppColors.title,
                                ),
                              ),
                            ),

                            if (note.isPinned)
                              const Icon(
                                Icons.push_pin,
                                size: 18,
                                color:
                                AppColors.primary,
                              ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Text(
                          note.content,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.body,
                          ),
                        ),

                        const SizedBox(height: 8),

                        if (note.audioUrl != null)
                          IconButton(
                            onPressed: () {
                              // هنا تضيفي كود تشغيل الصوت
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              color:
                              AppColors.primary,
                            ),
                          ),

                        const SizedBox(height: 8),

                        Text(
                          note.createdAt
                              .toDate()
                              .toString()
                              .substring(0, 16),
                          style: const TextStyle(
                            fontSize: 12,
                            color:
                            AppColors.subtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary
                  .withOpacity(0.35),
              blurRadius: 20,
              spreadRadius: 6,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: FloatingActionButton(
          backgroundColor:
          isDark ? AppColors.dr : AppColors.primary,

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
      ),
    );
  }
}