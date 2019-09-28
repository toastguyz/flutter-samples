import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_samples/note_keeper_app/models/note.dart';

class DatabaseHelper {
  // Singleton DatabaseHelper
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable = "note_table";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "priority";
  String colDate = "date";

  // Named Constructor to create instance of DatabaseHelper
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initialiseDatabase();
    }

    return _database;
  }

  Future<Database> initialiseDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "notes.db";

    // open/create the database at given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return notesDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE ${noteTable}($colId INTEGER PRIMARY KEY AUTOINCREMENT,${colTitle} TEXT,"
        "${colDescription} TEXT, ${colPriority} INTEGER,${colDate} TEXT)");
  }

  // Fetch operation : Get all note objects from database
  Future<List<Map<String, dynamic>>> getNotesMapList() async {
    var db = await this.database;

//    var result = await db.rawQuery("SELECT * FROM ${noteTable} order by ${colPriority} ASC");
    var result = await db.query(noteTable, orderBy: "$colPriority ASC");

    return result;
  }

  // Insert operation : Insert a note object to the database.
  Future<int> insertNote(Note note) async {
    var db = await this.database;

    var result = await db.insert(noteTable, note.convertLocalToMap());
    return result;
  }

  // Update operation : Update a note object and save it to the database.
  Future<int> updateNote(Note note) async {
    var db = await this.database;

    var result = await db.update(noteTable, note.convertLocalToMap(),
        where: "$colId=?", whereArgs: [note.id]);

    return result;
  }

  // Delete operation : Delete a note from the database.
  Future<int> deleteNote(int id) async {
    var db = await this.database;

    var result = await db.rawDelete("DELETE FROM $noteTable WHERE $colId = $id");
    return result;
  }

  // Get Number of Note Objects in the database.
  Future<int> getCount() async {
    var db = await this.database;
    List<Map<String, dynamic>> data =
        await db.rawQuery("SELECT COUNT (*) FROM $noteTable");
    var result = Sqflite.firstIntValue(data);

    return result;
  }

  Future<List<Note>> getNoteList() async {
    var notesMapList = await getNotesMapList();
    List<Note> notesList = List<Note>();

    for (int i = 0; i < notesMapList.length; i++) {
      notesList.add(Note.fromMapObject(notesMapList[i]));
    }

    return notesList;
  }
}
