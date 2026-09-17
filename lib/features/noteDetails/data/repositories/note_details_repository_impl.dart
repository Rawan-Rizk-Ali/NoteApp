
import 'package:noteapp/features/noteDetails/data/datasources/note_details_remote_datasource.dart';
import 'package:noteapp/features/noteDetails/domain/repostries/note_details_repository.dart';

class NoteDetailsRepositoryImpl
    implements NoteDetailsRepository {
  final NoteDetailsRemoteDataSource _remoteDataSource;

  NoteDetailsRepositoryImpl({
    required NoteDetailsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<void> deleteImage({
    required String noteId,
    required String imageUrl,
    required List<String> currentImages,
  }) {
    return _remoteDataSource.deleteImage(
      noteId: noteId,
      imageUrl: imageUrl,
      currentImages: currentImages,
    );
  }

  @override
  Future<void> togglePin({
    required String noteId,
    required bool isPinned,
  }) {
    return _remoteDataSource.togglePin(
      noteId: noteId,
      isPinned: isPinned,
    );
  }

  @override
  Future<void> deleteNote({
    required String noteId,
  }) {
    return _remoteDataSource.deleteNote(
      noteId: noteId,
    );
  }
}