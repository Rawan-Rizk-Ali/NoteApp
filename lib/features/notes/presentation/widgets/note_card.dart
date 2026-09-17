import 'package:flutter/material.dart';
import 'package:noteapp/core/constant/app_color.dart';
import 'package:noteapp/features/noteDetails/presentation/pages/note_dateils_screen.dart';
import 'package:noteapp/features/notes/domain/entities/note.dart';
class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
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
            borderRadius: BorderRadius.circular(18),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.title,
                      ),
                    ),
                  ),
                  if (note.isPinned)
                    const Icon(
                      Icons.push_pin,
                      size: 18,
                      color: AppColors.primary,
                    ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                note.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.body,
                ),
              ),

              if (note.audioUrl != null &&
                  note.audioUrl!.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_circle_fill,
                        color: AppColors.primary,
                        size: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Audio Recording",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 8),

              Text(
                note.createdAt
                    
                    .toString()
                    .substring(0, 16),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.subtitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}