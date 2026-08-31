import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../core/constant/app_color.dart';
import '../data/services/firebase_service.dart';
import '../model/note_model.dart';
import 'add_note.dart';

class NoteDetailsScreen extends StatefulWidget {
  final NoteModel note;

  const NoteDetailsScreen({
    super.key,
    required this.note,
  });

  @override
  State<NoteDetailsScreen> createState() =>
      _NoteDetailsScreenState();
}

class _NoteDetailsScreenState
    extends State<NoteDetailsScreen> {
  final FirebaseService firebaseService =
      FirebaseService();

  final AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen(
      (state) {
        if (mounted) {
          setState(() {
            isPlaying =
                state == PlayerState.playing;
          });
        }
      },
    );
  }

  Future<void> playAudio() async {
    if (widget.note.audioUrl == null ||
        widget.note.audioUrl!.isEmpty) {
      return;
    }

    final file = File(widget.note.audioUrl!);

    if (!await file.exists()) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Recording file not found",
          ),
        ),
      );

      return;
    }

    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(
        DeviceFileSource(
          widget.note.audioUrl!,
        ),
      );
    }
  }

  Future<void> deleteImage(
    String imageUrl,
  ) async {
    final updatedImages =
        List<String>.from(widget.note.imageUrls);

    updatedImages.remove(imageUrl);

    await FirebaseFirestore.instance
        .collection("notes")
        .doc(widget.note.id)
        .update({
      "imageUrls": updatedImages,
    });

    setState(() {
      widget.note.imageUrls.remove(imageUrl);
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context)
                .appBarTheme
                .backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark
                ? AppColors.dr
                : AppColors.icon,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.note.title,
                                    style:
                                        const TextStyle(
                                      fontSize: 38,
                                      fontWeight:
                                          FontWeight.bold,
                                      color:
                                          AppColors.title,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  widget.note.createdAt
                                      .toDate()
                                      .toString()
                                      .substring(
                                        0,
                                        16,
                                      ),
                                  style:
                                      const TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        AppColors.subtitle,
                                  ),
                                ),
                                const Spacer(),
                                if (widget.note.isPinned)
                                  const Icon(
                                    Icons.push_pin,
                                    size: 18,
                                    color:
                                        AppColors.icon,
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
                              widget.note.content,
                              style:
                                  GoogleFonts.carlito(
                                fontSize: 30,
                                height: 1.8,
                                color:
                                    AppColors.body,
                                fontWeight:
                                    FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),

                    if (widget.note.imageUrls.isNotEmpty)
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection:
                              Axis.horizontal,
                          itemCount:
                              widget.note.imageUrls.length,
                          itemBuilder:
                              (context, index) {
                            final imageUrl =
                                widget.note.imageUrls[
                                    index];

                            return Stack(
                              children: [
                                Container(
                                  width: 250,
                                  margin:
                                      const EdgeInsets
                                          .only(
                                    right: 12,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      15,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      15,
                                    ),
                                    child:
                                        Image.network(
                                      imageUrl,
                                      width: 250,
                                      height: 180,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container(
                                          color: AppColors
                                              .cardBackground,
                                          alignment:
                                              Alignment
                                                  .center,
                                          child:
                                              const Icon(
                                            Icons
                                                .broken_image,
                                            size: 40,
                                            color: AppColors
                                                .subtitle,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 20,
                                  child:
                                      GestureDetector(
                                    onTap: () async {
                                      await deleteImage(
                                        imageUrl,
                                      );
                                    },
                                    child:
                                        Container(
                                      padding:
                                          const EdgeInsets
                                              .all(
                                        6,
                                      ),
                                      decoration:
                                          const BoxDecoration(
                                        color:
                                            Colors.black54,
                                        shape:
                                            BoxShape.circle,
                                      ),
                                      child:
                                          const Icon(
                                        Icons.close,
                                        color:
                                            Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                    if (widget.note.imageUrls.isNotEmpty)
                      const SizedBox(height: 20),

                    if (widget.note.audioUrl != null &&
                        widget.note.audioUrl!.isNotEmpty)
                      GestureDetector(
                        onTap: playAudio,
                        child: Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors
                                .cardBackground,
                            borderRadius:
                                BorderRadius.circular(
                              15,
                            ),
                            border: Border.all(
                              color:
                                  AppColors.border,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration:
                                    BoxDecoration(
                                  color: AppColors
                                      .primary,
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    14,
                                  ),
                                ),
                                child: Icon(
                                  isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  isPlaying
                                      ? "Playing recording..."
                                      : "Audio Recording",
                                  style:
                                      const TextStyle(
                                    fontSize: 17,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        AppColors.title,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.mic,
                                color:
                                    AppColors.primary,
                                size: 26,
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    Share.share(
                      '${widget.note.title}\n\n${widget.note.content}',
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
                        builder: (_) =>
                            AddNoteScreen(
                          note: widget.note,
                        ),
                      ),
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
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
                        .doc(widget.note.id)
                        .update({
                      "isPinned":
                          !widget.note.isPinned,
                    });

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(
                    widget.note.isPinned
                        ? Icons.push_pin
                        : Icons.push_pin_outlined,
                    color: AppColors.icon,
                  ),
                ),

                IconButton(
                  onPressed: () async {
                    await firebaseService.deleteNote(
                      widget.note.id!,
                    );

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