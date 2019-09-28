import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/note_keeper_app/database_helper.dart';
import 'package:flutter_samples/note_keeper_app/models/note.dart';
import 'package:flutter_samples/note_keeper_app/note_detail.dart';
import 'package:sqflite/sqflite.dart';

class NoteKeeperApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteKeeperAppState();
  }
}

class NoteKeeperAppState extends State<NoteKeeperApp> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  void updateListView() {
    Future<Database> dbFuture = databaseHelper.initialiseDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("NoteKeeper"),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Note("", "", 2), "Add Note");
        },
        tooltip: "Add Note",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getNoteListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    getPriorityColor(this.noteList[index].priority),
                child: getPriorityIcon(this.noteList[index].priority),
              ),
              title: Text(this.noteList[index].title),
              subtitle: Text(this.noteList[index].date),
              trailing: GestureDetector(
                onTap: () {
                  _delete(context, noteList[index]);
                },
                child: Icon(Icons.delete),
              ),
              onTap: () {
                navigateToDetail(this.noteList[index], "Edit Note");
              },
            ),
          );
        });
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
        break;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
        break;
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);

    if (result != 0) {
      _showSnackBar(context, "Note Deleted Successfully!!");
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return NoteDetail(note, title);
    }));

    if (result) {
      updateListView();
    }
  }
}
