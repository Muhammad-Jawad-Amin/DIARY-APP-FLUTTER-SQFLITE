import 'package:diary_app_sqflite/sqflite/note.dart';
import 'package:diary_app_sqflite/sqflite/notes_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotePart extends StatelessWidget {
  final Note note;

  const NotePart({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                note.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Text(
                  DateFormat(DateFormat.HOUR_MINUTE).format(note.createdAt),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Delete Note"),
                      content: const Text(
                          "Are you sure you want to delete this note?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteNote();
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white70,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future _deleteNote() async {
    NotesRepository.deleteNote(note: note);
  }
}
