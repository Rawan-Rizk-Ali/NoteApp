import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:noteapp/features/addNote/domain/repositories/add_note_repository.dart';
import 'package:noteapp/features/notes/domain/entities/note.dart';

class AddNoteProvider extends ChangeNotifier {
  final AddNoteRepository _repository;

  AddNoteProvider({
    required AddNoteRepository repository,
  }) : _repository = repository;

  bool _isSaving = false;
  String? _error;

  bool get isSaving => _isSaving;

  String? get error => _error;

  Future<bool> saveNote({
    required Note? existingNote,
    required String title,
    required String content,
    required List<File> selectedImages,
    required String? audioFilePath,
    required int colorIndex,
  }) async {
    if (title.trim().isEmpty &&
        content.trim().isEmpty) {
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    try {
      final imageUrls = <String>[];

      for (final image in selectedImages) {
        final url =
            await _repository.uploadImage(
          image.path,
        );

        if (url != null) {
          imageUrls.add(url);
        }
      }

      final note = Note(
        id: existingNote?.id,
        title: title.trim(),
        content: content.trim(),
        imageUrls: imageUrls.isNotEmpty
            ? imageUrls
            : (existingNote?.imageUrls ?? []),
        audioUrl:
            audioFilePath ?? existingNote?.audioUrl,
        colorIndex: colorIndex,
        isPinned:
            existingNote?.isPinned ?? false,
        createdAt:
            existingNote?.createdAt ??
                DateTime.now(),
      );

      if (existingNote == null) {
        await _repository.addNote(note);
      } else {
        await _repository.updateNote(note);
      }

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}