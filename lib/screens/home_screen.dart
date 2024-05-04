import "package:diary_app_sqflite/manage-state/notes_provider.dart";
import "package:diary_app_sqflite/screens/addnote_screen.dart";
import "package:diary_app_sqflite/widgets/item_note.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "MY DIARY",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            wordSpacing: 10,
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<NotesProvider>(builder: (context, provider, child) {
        if (provider.notes.isEmpty) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: const EdgeInsets.all(20),
              child: const Text(
                "No Notes Yet!",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: provider.notes.length,
              itemBuilder: (context, index) {
                return ItemNote(
                  note: provider.notes[index],
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddNoteScreen();
              },
            ),
          );
          setState(() {});
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
