import 'dart:convert';

class QQQQ {
  String id;
  String name;
  String zzzz;
  QQQQ({
    required this.id,
    required this.name,
    required this.zzzz,
  });

  DBIdName? toCommon([String ignoreId = ""]) {
    if (id.isEmpty || id == ignoreId) {
      return null;
    } else {
      return DBIdName(id: id, name: name);
    }
  }
}

class DBIdName extends Object {
  DBIdName({required this.id, required this.name});

  final String id;
  String name;

  factory DBIdName.init() => DBIdName(id: "", name: "");

  factory DBIdName.fromMap(Map<String, dynamic>? map) =>
      DBIdName(id: map?['id'] ?? "", name: map?['name'] ?? "");

  DBIdName copyWith({String? id, String? name}) =>
      DBIdName(id: id ?? this.id, name: name ?? this.name);

  Map<String, String> toMap() => {'id': id, 'name': name};

  @override
  bool operator ==(Object other) {
    if (other is DBIdName) {
      return other.id == id;
    } else if (other is String) {
      return other == id;
    } else {
      return false;
    }
  }

  String toJson() => json.encode(toMap());
  factory DBIdName.fromJson(String source) =>
      DBIdName.fromMap(json.decode(source));

  @override
  String toString() => name;

  @override
  int get hashCode => id.hashCode;
}
