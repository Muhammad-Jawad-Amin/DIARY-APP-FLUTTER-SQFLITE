import 'package:diary_app_sqflite/sqflite/note.dart';
import 'package:diary_app_sqflite/sqflite/notes_repository.dart';
import 'package:flutter/material.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  Future getNotes() async {
    notes = await NotesRepository.getNotes();
    notifyListeners();
  }

  Future insertNote({required Note note}) async {
    await NotesRepository.insertNote(note: note);
    getNotes();
  }

  Future updateNote({required Note note}) async {
    await NotesRepository.updateNote(note: note);
    getNotes();
  }

  Future deleteNote({required Note note}) async {
    await NotesRepository.deleteNote(note: note);
    getNotes();
  }
}
