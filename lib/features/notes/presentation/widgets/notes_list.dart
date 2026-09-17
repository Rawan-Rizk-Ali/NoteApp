import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:noteapp/core/localization/app_strings.dart';
import '../provider/notes_provider.dart';
import 'note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<
        NotesProvider,
        ({
          List notes,
          bool isLoading,
          String? error,
        })>(
      selector: (_, provider) => (
        notes: provider.notes,
        isLoading: provider.isLoading,
        error: provider.error,
      ),
      builder: (
        context,
        state,
        child,
      ) {
        if (state.error != null) {
          return Center(
            child: Text(
              state.error!,
            ),
          );
        }

        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.notes.isEmpty) {
          return Center(
            child: Text(
              AppStrings.tr("no_data"),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          itemCount: state.notes.length,
          itemBuilder: (context, index) {
            final note = state.notes[index];

            return NoteCard(
              key: ValueKey(note.id),
              note: note,
            );
          },
        );
      },
    );
  }
}