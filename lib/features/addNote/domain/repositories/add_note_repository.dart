import 'package:noteapp/features/notes/domain/entities/note.dart';

abstract class AddNoteRepository {
  Future<void> addNote(Note note);

  Future<void> updateNote(Note note);

  Future<String?> uploadImage(String imagePath);
}