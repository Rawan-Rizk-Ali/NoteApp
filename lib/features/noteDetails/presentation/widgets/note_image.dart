import 'package:flutter/material.dart';

import 'package:noteapp/core/constant/app_color.dart';
import 'package:noteapp/features/notes/domain/entities/note.dart';

class NoteImages extends StatelessWidget {
  final Note note;
  final Future<void> Function(String imageUrl) onDeleteImage;

  const NoteImages({
    super.key,
    required this.note,
    required this.onDeleteImage,
  });

  @override
  Widget build(BuildContext context) {
    if (note.imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: note.imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = note.imageUrls[index];

          return Stack(
            children: [
              Container(
                width: 250,
                margin: const EdgeInsets.only(
                  right: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(15),
                  child: Image.network(
                    imageUrl,
                    width: 250,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Container(
                        color:
                            AppColors.cardBackground,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image,
                          size: 40,
                          color:
                              AppColors.subtitle,
                        ),
                      );
                    },
                  ),
                ),
              ),

              Positioned(
                top: 8,
                right: 20,
                child: GestureDetector(
                  onTap: () async {
                    await onDeleteImage(imageUrl);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.all(6),
                    decoration:
                        const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}