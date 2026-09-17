import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteapp/features/notes/data/models/note_models.dart';
class FirebaseService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addNote(NoteModel note) async {
    await _firestore
        .collection("notes")
        .add(
      note.toJson(),
    );
  }

  Future<void> updateNote(NoteModel note) async {
    await _firestore
        .collection("notes")
        .doc(note.id)
        .update(note.toJson());
  }

  Future<void> deleteNote(String id) async {
    await _firestore
        .collection("notes")
        .doc(id)
        .delete();
  }
}