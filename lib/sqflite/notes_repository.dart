import 'package:diary_app_sqflite/sqflite/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesRepository {
  static const _databaseName = "notes_database.db";
  static const _tableName = "notes";

  static Future<Database> _database() async {
    final database = openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdAt TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  static Future<void> insertNote({required Note note}) async {
    final db = await _database();
    await db.insert(
      _tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateNote({required Note note}) async {
    final db = await _database();
    await db.update(
      _tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<void> deleteNote({required Note note}) async {
    final db = await _database();
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<List<Note>> getNotes() async {
    final db = await _database();
    final List<Map<String, Object?>> noteMaps = await db.query(_tableName);

    return [
      for (final noteMap in noteMaps)
        Note(
          id: noteMap['id'] as int,
          title: noteMap['title'] as String,
          description: noteMap['description'] as String,
          createdAt: DateTime.parse(noteMap['createdAt'] as String),
        ),
    ];
  }

  static Future<int> getId() async {
    final db = await _database();
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT MAX(id) FROM $_tableName'))!;
  }
}
