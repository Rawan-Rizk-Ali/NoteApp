import 'package:noteapp/features/addNote/data/datasources/add_note_remote_datasource.dart';
import 'package:noteapp/features/addNote/data/datasources/image_upload_datasource.dart';
import 'package:noteapp/features/addNote/domain/repositories/add_note_repository.dart';
import 'package:noteapp/features/notes/data/models/note_models.dart';
import 'package:noteapp/features/notes/domain/entities/note.dart';

class AddNoteRepositoryImpl
    implements AddNoteRepository {
  final AddNoteRemoteDataSource _remoteDataSource;
  final ImageUploadDataSource _imageUploadDataSource;

  AddNoteRepositoryImpl({
    required AddNoteRemoteDataSource remoteDataSource,
    required ImageUploadDataSource imageUploadDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _imageUploadDataSource = imageUploadDataSource;

  @override
  Future<void> addNote(Note note) {
    final model = NoteModel.fromEntity(note);

    return _remoteDataSource.addNote(model);
  }

  @override
  Future<void> updateNote(Note note) {
    final model = NoteModel.fromEntity(note);

    return _remoteDataSource.updateNote(model);
  }

  @override
  Future<String?> uploadImage(
    String imagePath,
  ) {
    return _imageUploadDataSource.uploadImage(
      imagePath,
    );
  }
}