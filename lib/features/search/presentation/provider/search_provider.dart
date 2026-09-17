import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:noteapp/features/notes/domain/entities/note.dart';
import 'package:noteapp/features/notes/domain/repositories/notes_repository.dart';

class SearchProvider extends ChangeNotifier {
  final NotesRepository repository;

  SearchProvider({
    required this.repository,
  }) {
    _listenToNotes();
  }

  StreamSubscription<List<Note>>? _subscription;

  List<Note> _allNotes = [];
  List<Note> _filteredNotes = [];

  String _query = '';

  bool _isLoading = true;
  String? _error;

  List<Note> get notes => _filteredNotes;

  bool get isLoading => _isLoading;

  String? get error => _error;

  String get searchText => _query;

  void _listenToNotes() {
    _subscription = repository.getNotes().listen(
      (notes) {
        _allNotes = notes;

        _filterNotes();

        _isLoading = false;
        _error = null;

        notifyListeners();
      },
      onError: (error) {
        _isLoading = false;
        _error = error.toString();

        notifyListeners();
      },
    );
  }

  void search(String value) {
    _query = value.trim();

    _filterNotes();

    notifyListeners();
  }

  void _filterNotes() {
    if (_query.isEmpty) {
      _filteredNotes = List<Note>.from(_allNotes);
      return;
    }

    final query = _query.toLowerCase();

    _filteredNotes = _allNotes.where((note) {
      final title = note.title.trim().toLowerCase();

      return title.contains(query);
    }).toList();
  }

  void clearSearch() {
    _query = '';

    _filterNotes();

    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}