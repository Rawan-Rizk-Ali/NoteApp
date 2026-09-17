import 'package:flutter/material.dart';
import 'package:noteapp/features/notes/domain/repositories/notes_repository_impl.dart';
import 'package:provider/provider.dart';

import 'package:noteapp/features/notes/data/datasources/notes_remote_datasource.dart';

import 'package:noteapp/features/notes/domain/repositories/notes_repository.dart';
import 'package:noteapp/features/notes/presentation/provider/notes_provider.dart';
import 'package:noteapp/features/notes/presentation/widgets/add_note_fab.dart';
import 'package:noteapp/features/notes/presentation/widgets/home_app_bar.dart';
import 'package:noteapp/features/notes/presentation/widgets/notes_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotesProvider>(
      create: (_) {
        final NotesRepository repository =
            NotesRepositoryImpl(
          remoteDataSource:
              NotesRemoteDataSource(),
        );

        final provider = NotesProvider(
          repository: repository,
        );

        provider.startListening();

        return provider;
      },
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: const HomeAppBar(),
      body: const NotesList(),
      floatingActionButton: const AddNoteFab(),
    );
  }
}