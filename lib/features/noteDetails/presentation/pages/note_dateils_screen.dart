import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/features/addNote/presentation/pages/add_note.dart';
import 'package:noteapp/features/noteDetails/data/datasources/note_details_remote_datasource.dart';
import 'package:noteapp/features/noteDetails/data/repositories/note_details_repository_impl.dart';
import 'package:noteapp/features/noteDetails/domain/repostries/note_details_repository.dart';
import 'package:noteapp/features/noteDetails/presentation/provider/note_details_provider.dart';
import 'package:noteapp/features/noteDetails/presentation/widgets/note_image.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:noteapp/core/constant/app_color.dart';
import 'package:noteapp/features/notes/domain/entities/note.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Note note;

  const NoteDetailsScreen({
    super.key,
    required this.note,
  });

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  String? audioUrl;

  @override
  void initState() {
    super.initState();

    audioUrl = widget.note.audioUrl;

    audioPlayer.onPlayerStateChanged.listen(
      (state) {
        if (mounted) {
          setState(() {
            isPlaying = state == PlayerState.playing;
          });
        }
      },
    );
  }

  Future<void> playAudio() async {
    if (audioUrl == null || audioUrl!.isEmpty) {
      return;
    }

    final file = File(audioUrl!);

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
          audioUrl!,
        ),
      );
    }
  }

  Future<void> deleteImage(
    NoteDetailsProvider provider,
    String imageUrl,
  ) async {
    final success = await provider.deleteImage(
      note: widget.note,
      imageUrl: imageUrl,
    );

    if (!mounted) return;

    if (success) {
      setState(() {});
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          provider.error ?? 'Failed to delete image',
        ),
      ),
    );
  }

  Future<void> togglePin(
    NoteDetailsProvider provider,
  ) async {
    if (widget.note.id == null) {
      return;
    }

    final success = await provider.togglePin(
      note: widget.note,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          provider.error ?? 'Failed to update pin',
        ),
      ),
    );
  }

  Future<void> deleteNote(
    NoteDetailsProvider provider,
  ) async {
    if (widget.note.id == null) {
      return;
    }

    final success = await provider.deleteNote(
      noteId: widget.note.id!,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          provider.error ?? 'Failed to delete note',
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return ChangeNotifierProvider(
      create: (_) {
        final NoteDetailsRepository repository =
            NoteDetailsRepositoryImpl(
          remoteDataSource:
              NoteDetailsRemoteDataSource(),
        );

        return NoteDetailsProvider(
          repository: repository,
        );
      },
      child: Consumer<NoteDetailsProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor,
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
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.note.createdAt
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
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  const Divider(
                                    thickness: 2,
                                    color:
                                        AppColors.body,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          NoteImages(
                            note: widget.note,
                            onDeleteImage: (imageUrl) {
                              return deleteImage(
                                provider,
                                imageUrl,
                              );
                            },
                          ),
                          if (widget
                              .note
                              .imageUrls
                              .isNotEmpty)
                            const SizedBox(
                              height: 20,
                            ),
                          if (audioUrl != null &&
                              audioUrl!.isNotEmpty)
                            GestureDetector(
                              onTap: playAudio,
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 15,
                                ),
                                decoration:
                                    BoxDecoration(
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
                                        color:
                                            AppColors.primary,
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
                                        color:
                                            Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
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
                                    IconButton(
                                      onPressed: () async {
                                        await audioPlayer.stop();

                                        if (!mounted) return;

                                        setState(() {
                                          audioUrl = null;
                                          isPlaying = false;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color:
                                            AppColors.icon,
                                        size: 26,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.mic,
                                      color:
                                          AppColors.primary,
                                      size: 26,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 25,
                          ),
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
                        onPressed: () {
                          togglePin(provider);
                        },
                        icon: Icon(
                          widget.note.isPinned
                              ? Icons.push_pin
                              : Icons.push_pin_outlined,
                          color: AppColors.icon,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteNote(provider);
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
        },
      ),
    );
  }
}