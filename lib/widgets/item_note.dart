import "package:diary_app_sqflite/screens/updatenote_screen.dart";
import "package:diary_app_sqflite/sqflite/note.dart";
import "package:diary_app_sqflite/widgets/date_part.dart";
import "package:diary_app_sqflite/widgets/note_part.dart";
import "package:flutter/material.dart";

class ItemNote extends StatelessWidget {
  final Note note;

  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateNoteScreen(note: note),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            DatePart(date: note.createdAt),
            const SizedBox(
              width: 15,
            ),
            NotePart(
              note: note,
            ),
          ],
        ),
      ),
    );
  }
}
