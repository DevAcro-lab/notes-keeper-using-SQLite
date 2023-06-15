class NoteModel {
  int? _id;
  String? _title;
  String? _description;

  NoteModel(
      {int? id,
      required String title,
      required String description,
      })
      : _id = id,
        _title = title,
        _description = description;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }

  NoteModel.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
  }
}
