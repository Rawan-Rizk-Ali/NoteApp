import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/constant/app_color.dart';
import '../model/note_model.dart';
import 'note_dateils_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: isDark ? AppColors.dr: AppColors.icon,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Container(
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.border,
                width: 1.2,
              ),
            ),
            child: TextField(
              controller: searchController,
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search notes...",
                hintStyle: TextStyle(
                  color: AppColors.title,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchText.isEmpty
                    ? null
                    : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      searchText = "";
                    });
                  },
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("notes")
                .orderBy("createdAt", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final notes = snapshot.data!.docs
                  .map((e) => NoteModel.fromFirestore(e))
                  .where((note) {
                return note.title.toLowerCase().contains(searchText) ||
                    note.content.toLowerCase().contains(searchText);
              }).toList();

              if (notes.isEmpty) {
                return const Center(
                  child: Text(
                    "No notes found",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.subtitle,
                    ),
                  ),
                );
              }

              return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];

                    return GestureDetector(
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
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.noteColors[
                            note.colorIndex %
                                AppColors.noteColors.length],
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Row(
                          children: [
                          Expanded(
                          child: Text(
                            note.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.title,
                            ),
                          ),
                        ),
                        if (note.isPinned)
                    const Icon(
                      Icons.push_pin,
                      color: AppColors.primary,
                    ),
                    ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.body,
                    ),
                    ),Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.body,
                    ),
                    ),
                              const SizedBox(height: 12),

                              if (note.imageUrl != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    note.imageUrl!,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              if (note.audioUrl != null)
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Icon(
                                    Icons.play_circle_fill,
                                    color: AppColors.primary,
                                    size: 28,
                                  ),
                                ),

                              const SizedBox(height: 10),

                              Text(
                                note.createdAt.toDate().toString().substring(0, 16),
                                style: const TextStyle(
                                  color: AppColors.subtitle,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                    );
                  },
              );
            },
        ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}