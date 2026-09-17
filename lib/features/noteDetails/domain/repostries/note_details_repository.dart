

abstract class NoteDetailsRepository {
  Future<void> deleteImage({
    required String noteId,
    required String imageUrl,
    required List<String> currentImages,
  });

  Future<void> togglePin({
    required String noteId,
    required bool isPinned,
  });

  Future<void> deleteNote({
    required String noteId,
  });
}