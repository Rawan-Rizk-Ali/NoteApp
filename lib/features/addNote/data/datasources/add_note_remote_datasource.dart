import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteapp/features/notes/data/models/note_models.dart';

class AddNoteRemoteDataSource {
  final FirebaseFirestore _firestore;

  AddNoteRemoteDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore =
            firestore ?? FirebaseFirestore.instance;

  Future<void> addNote(NoteModel note) async {
    await _firestore
        .collection('notes')
        .add(note.toJson());
  }

  Future<void> updateNote(NoteModel note) async {
    if (note.id == null) {
      throw Exception('Note id is required for update');
    }

    await _firestore
        .collection('notes')
        .doc(note.id)
        .update(note.toJson());
  }
}