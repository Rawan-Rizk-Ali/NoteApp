import 'package:cloud_firestore/cloud_firestore.dart';

class NoteDetailsRemoteDataSource {
  final FirebaseFirestore _firestore;

  NoteDetailsRemoteDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore =
            firestore ?? FirebaseFirestore.instance;

  Future<void> deleteImage({
    required String noteId,
    required String imageUrl,
    required List<String> currentImages,
  }) async {
    final updatedImages =
        List<String>.from(currentImages);

    updatedImages.remove(imageUrl);

    await _firestore
        .collection('notes')
        .doc(noteId)
        .update({
      'imageUrls': updatedImages,
    });
  }

  Future<void> togglePin({
    required String noteId,
    required bool isPinned,
  }) async {
    await _firestore
        .collection('notes')
        .doc(noteId)
        .update({
      'isPinned': !isPinned,
    });
  }

  Future<void> deleteNote({
    required String noteId,
  }) async {
    await _firestore
        .collection('notes')
        .doc(noteId)
        .delete();
  }
}