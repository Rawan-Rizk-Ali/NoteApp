import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:noteapp/features/notes/domain/entities/note.dart';

class NoteModel {
  final String? id;
  final String title;
  final String content;
  final List<String> imageUrls;
  final String? audioUrl;
  final int colorIndex;
  final bool isPinned;
  final Timestamp createdAt;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrls = const [],
    this.audioUrl,
    required this.colorIndex,
    this.isPinned = false,
    required this.createdAt,
  });

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception(
        "Document ${doc.id} has no data",
      );
    }

    final List<String> images =
        data['imageUrls'] != null
            ? List<String>.from(data['imageUrls'])
            : [];

    return NoteModel(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrls: images,
      audioUrl: data['audioUrl'],
      colorIndex: data['colorIndex'] ?? 0,
      isPinned: data['isPinned'] ?? false,
      createdAt:
          data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "imageUrls": imageUrls,
      "audioUrl": audioUrl,
      "colorIndex": colorIndex,
      "isPinned": isPinned,
      "createdAt": createdAt,
    };
  }

  Note toEntity() {
    return Note(
      id: id,
      title: title,
      content: content,
      imageUrls: imageUrls,
      audioUrl: audioUrl,
      colorIndex: colorIndex,
      isPinned: isPinned,
      createdAt: createdAt.toDate(),
    );
  }

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      imageUrls: note.imageUrls,
      audioUrl: note.audioUrl,
      colorIndex: note.colorIndex,
      isPinned: note.isPinned,
      createdAt: Timestamp.fromDate(note.createdAt),
    );
  }
}