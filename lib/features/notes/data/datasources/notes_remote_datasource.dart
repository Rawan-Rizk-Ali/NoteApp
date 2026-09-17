import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteapp/features/notes/data/models/note_models.dart';


class NotesRemoteDataSource {
  final FirebaseFirestore _firestore;

  NotesRemoteDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore =
            firestore ?? FirebaseFirestore.instance;

  Stream<List<NoteModel>> getNotes() {
    return _firestore
        .collection('notes')
        .orderBy(
          'isPinned',
          descending: true,
        )
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) {
            return snapshot.docs
                .map(
                  (doc) => NoteModel.fromFirestore(doc),
                )
                .toList();
          },
        );
  }
}