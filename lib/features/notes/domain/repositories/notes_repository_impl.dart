import 'package:noteapp/features/notes/data/datasources/notes_remote_datasource.dart';
import 'package:noteapp/features/notes/domain/entities/note.dart';
import 'package:noteapp/features/notes/domain/repositories/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDataSource _remoteDataSource;

  NotesRepositoryImpl({
    required NotesRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Stream<List<Note>> getNotes() {
    return _remoteDataSource.getNotes().map(
      (models) => models
          .map((model) => model.toEntity())
          .toList(),
    );
  }
}