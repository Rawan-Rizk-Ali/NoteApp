import 'package:flutter/foundation.dart';
import 'package:noteapp/features/noteDetails/domain/repostries/note_details_repository.dart';
import 'package:noteapp/features/notes/domain/entities/note.dart';

class NoteDetailsProvider extends ChangeNotifier {
  final NoteDetailsRepository _repository;

  NoteDetailsProvider({
    required NoteDetailsRepository repository,
  }) : _repository = repository;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> deleteImage({
    required Note note,
    required String imageUrl,
  }) async {
    if (note.id == null) {
      _error = 'Note id is required';
      notifyListeners();
      return false;
    }

    _setLoading(true);

    try {
      await _repository.deleteImage(
        noteId: note.id!,
        imageUrl: imageUrl,
        currentImages: note.imageUrls,
      );

      note.imageUrls.remove(imageUrl);

      _error = null;

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> togglePin({
    required Note note,
  }) async {
    if (note.id == null) {
      _error = 'Note id is required';
      notifyListeners();
      return false;
    }

    _setLoading(true);

    try {
      await _repository.togglePin(
        noteId: note.id!,
        isPinned: note.isPinned,
      );

      _error = null;

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteNote({
    required String noteId,
  }) async {
    _setLoading(true);

    try {
      await _repository.deleteNote(
        noteId: noteId,
      );

      _error = null;

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}