class DataModel {
  DataModel({
      int? id, 
      String? title, 
      String? body,}){
    _id = id;
    _title = title;
    _body = body;
}

  DataModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
  }
  int? _id;
  String? _title;
  String? _body;

  int? get id => _id;
  String? get title => _title;
  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }

}