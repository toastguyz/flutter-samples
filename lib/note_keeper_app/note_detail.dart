import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/note_keeper_app/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:flutter_samples/note_keeper_app/models/note.dart';

class NoteDetail extends StatefulWidget {
  final String title;
  final Note note;

  NoteDetail(this.note, this.title);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note);
  }
}

class NoteDetailState extends State<NoteDetail> {
  static var priorities = ["High", "Low"];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();

  Note note;

  NoteDetailState(this.note);

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: DropdownButton(
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      updatePriorityAsInt(valueSelectedByUser);
                    });
                  },
                  items: priorities.map((String dropDownItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownItem,
                      child: Text(dropDownItem),
                    );
                  }).toList(),
                  value: getPriorityAsString(note.priority),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  onChanged: (value) {
                    updateTitle();
                  },
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  onChanged: (value) {
                    updateDescription();
                  },
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Save",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _save();
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Delete",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _delete();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case "High":
        note.priority = 1;
        break;
      case "Low":
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = priorities[0];
        break;
      case 2:
        priority = priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    int result;
    note.date = DateFormat.yMMMd().format(DateTime.now());
    if (note.id != null) {
      result = await databaseHelper.updateNote(note);
    } else {
      result = await databaseHelper.insertNote(note);
    }

    if (result != 0) {
      _showAlertDialog("Statue", "Note Saved Successfully!!");
    } else {
      _showAlertDialog("Statue", "Problem saving Note!!");
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (note.id == null) {
      _showAlertDialog("Statue", "No Note was deleted !!");
      return;
    }

    var result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog("Statue", "Note Deleted Successfully!!");
    } else {
      _showAlertDialog("Statue", "Problem Deleting Note!!");
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog dialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => dialog);
  }
}
