class Excursion {

  int _id;
  String _title;
  String _description;
  String _local;
  String _date;

  Excursion(this._title, this._local, this._date, [this._description]);

  Excursion.withId(this._id, this._title, this._local, this._date, [this._description]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get local => _local;
  String get date => _date;

  set id(int value) {
    _id = value;
  }

  set title(String value) {
    _title = value;
  }

  set description(String value) {
    _description = value;
  }

  set local(String value) {
    _local = value;
  }

  set date(String value) {
    _date = value;
  }

  Map <String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    map["local"] = _local;
    map["date"] = _date;
    if(_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Excursion.fromObject(dynamic obj)  {
    this._id = obj["id"];
    this._title = obj["title"];
    this._description = obj["description"];
    this._local = obj["local"];
    this._date = obj["date"];
  }
}