import 'package:flutter/material.dart';
import 'package:notesapp/utils/database_helper.dart';
import '../models/note_model.dart';

class ProviderModel extends ChangeNotifier {
  List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  void fetchNotes() async {
    _notes = await SQLHelper.instance.fetchNotesList();
    notifyListeners();
  }

  void addOrUpdateNote({int? id, String? title, String? description}) async {
    NoteModel noteModel = NoteModel(
        id: id, title: title.toString(), description: description.toString());
    if (id != null) {
      await SQLHelper.instance.updateNote(noteModel);
    } else {
      await SQLHelper.instance.insertNote(noteModel);
    }

    fetchNotes();
  }

  void deleteNote(int id) async {
    await SQLHelper.instance.deleteNote(id);
    fetchNotes();
  }
}
