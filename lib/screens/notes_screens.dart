import 'package:flutter/material.dart';
import 'package:notesapp/provider/provider.dart';
import 'package:notesapp/screens/note_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<ProviderModel>(context);
    List<NoteModel> notes = notesProvider.notes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteDetailScreen(
                            note: note,
                            title: 'Update Note',
                            buttonName: 'Update',
                          )));
                },
                child: ListTile(
                  title: Text(note.title!),
                  subtitle: Text(note.description!),
                  leading: const Icon(
                    Icons.task_outlined,
                    size: 40,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      notesProvider.deleteNote(note.id!);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailScreen(
                    title: 'Add Note',
                    buttonName: 'Add',
                  )));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
