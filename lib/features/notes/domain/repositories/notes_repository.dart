import 'package:noteapp/features/notes/domain/entities/note.dart';

abstract class NotesRepository {
  Stream<List<Note>> getNotes();
}