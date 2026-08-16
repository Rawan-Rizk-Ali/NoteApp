import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constant/app_color.dart';
import '../data/services/firebase_service.dart';
import '../model/note_model.dart';
import 'add_note.dart';
import 'package:share_plus/share_plus.dart';


class NoteDetailsScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final NoteModel note;
  NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.icon),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        note.title,
                                        style: const TextStyle(
                                          fontSize: 38,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.title,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Text(
                                  note.createdAt
                                      .toDate()
                                      .toString()
                                      .substring(0, 16),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.subtitle,
                                  ),
                                ),

                                const Spacer(),

                                if (note.isPinned)
                                  const Icon(
                                    Icons.push_pin,
                                    size: 18,
                                    color: AppColors.icon,
                                  ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            const Divider(
                              thickness: 2,
                              color: AppColors.body,
                            ),

                            const SizedBox(height: 25),

                            Text(
                              note.content,
                              style: GoogleFonts.carlito(
                                fontSize: 30,
                                height: 1.8,
                                color: AppColors.body,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),

                    if (note.imageUrl != null)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(note.imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    if (note.audioUrl != null)
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_arrow,
                          color: AppColors.primary,
                        ),
                      ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    Share.share(
                      '${note.title}\n\n${note.content}',
                    );
                  },
                  icon: const Icon(
                    Icons.share,
                    color: AppColors.icon,
                  ),
                ),

                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddNoteScreen(note: note),
                      ),
                    );

                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.icon,
                  ),
                ),

                IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("notes")
                        .doc(note.id)
                        .update({"isPinned": !note.isPinned});

                    Navigator.pop(context);
                  },
                  icon: Icon(
                    note.isPinned
                        ? Icons.push_pin
                        : Icons.push_pin_outlined,
                    color: AppColors.icon,
                  ),
                ),

                IconButton(
                  onPressed: () async {
                    await firebaseService.deleteNote(note.id!);

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.icon,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
