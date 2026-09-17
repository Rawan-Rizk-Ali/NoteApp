import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:noteapp/features/notes/domain/entities/note.dart';
import 'package:noteapp/features/notes/domain/repositories/notes_repository.dart';

class NotesProvider extends ChangeNotifier {
  final NotesRepository _repository;

  NotesProvider({
    required NotesRepository repository,
  }) : _repository = repository;

  StreamSubscription<List<Note>>? _notesSubscription;

  List<Note> _notes = const [];

  bool _isLoading = true;

  String? _error;

  List<Note> get notes => _notes;

  bool get isLoading => _isLoading;

  String? get error => _error;

  void startListening() {
    if (_notesSubscription != null) {
      return;
    }

    _isLoading = true;
    _error = null;

    _notesSubscription =
        _repository.getNotes().listen(
      (notes) {
        _notes = List.unmodifiable(notes);

        _isLoading = false;
        _error = null;

        notifyListeners();
      },
      onError: (error) {
        _error = error.toString();
        _isLoading = false;

        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _notesSubscription?.cancel();
    _notesSubscription = null;

    super.dispose();
  }
}