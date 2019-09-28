class Note {
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

  Note(this._title, this._date, this._priority, [this._description]);

  Note.withID(this._id, this._title, this._date, this._priority,
      [this._description]);

  String get date => _date;

  int get priority => _priority;

  String get description => _description;

  String get title => _title;

  int get id => _id;

  set date(String value) {
    _date = value;
  }

  set priority(int value) {
    _priority = value;
  }

  set description(String value) {
    _description = value;
  }

  set title(String value) {
    _title = value;
  }

  // Convert a note object in to a Map object
  Map<String, dynamic> convertLocalToMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map["id"] = _id;
    }
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;

    return map;
  }

  // Extract a note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._title = map["title"];
    this._description = map["description"];
    this._priority = map["priority"];
    this._date = map["date"];
  }
}
