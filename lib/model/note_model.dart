import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String title;
  final String content;

  // Multiple images
  final List<String> imageUrls;

  final String? audioUrl;
  final int colorIndex;
  final bool isPinned;
  final Timestamp createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrls = const [],
    this.audioUrl,
    required this.colorIndex,
    this.isPinned = false,
    required this.createdAt,
  });

  // =========================
  // TO JSON
  // =========================

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

  // =========================
  // FROM FIRESTORE
  // =========================

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception(
        "Document ${doc.id} has no data",
      );
    }

    // Handle imageUrls as List
    final List<String> images = data['imageUrls'] != null
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
}