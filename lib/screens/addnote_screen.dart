import 'dart:async';
import 'package:diary_app_sqflite/manage-state/notes_provider.dart';
import 'package:diary_app_sqflite/sqflite/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.note != null ? "UPDATE NOTE" : "ADD NOTE",
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              wordSpacing: 10,
              letterSpacing: 5,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 50,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: const Size(120, 50),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.note != null) {
                        _updateNote();
                      } else {
                        _insertNote();
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: const Size(120, 50),
                    ),
                    child: Text(
                      widget.note != null ? "Update" : "Save",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _insertNote() async {
    final note = Note(
      title: _titleController.text,
      description: _descriptionController.text,
      createdAt: DateTime.now(),
    );
    Provider.of<NotesProvider>(context, listen: false).insertNote(note: note);
  }

  Future _updateNote() async {
    final note = Note(
      id: widget.note!.id,
      title: _titleController.text,
      description: _descriptionController.text,
      createdAt: widget.note!.createdAt,
    );
    Provider.of<NotesProvider>(context, listen: false).updateNote(note: note);
  }
}
