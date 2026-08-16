import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String title;
  final String content;
  final String? imageUrl;
  final String? audioUrl;
  final int colorIndex;
  final bool isPinned;
  final Timestamp createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.audioUrl,
    required this.colorIndex,
    this.isPinned = false,
    required this.createdAt,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "imageUrl": imageUrl,
      "audioUrl": audioUrl,
      "colorIndex": colorIndex,
      "isPinned": isPinned,
      "createdAt": createdAt,
    };
  }

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?; 
    if (data == null) {
      throw Exception("Document ${doc.id} has no data");
    }

    return NoteModel(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'],
      audioUrl: data['audioUrl'],
      colorIndex: data['colorIndex'] ?? 0,
      isPinned: data['isPinned'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );

  }

}