class ClassRoomsData {
  int size;
  int id;
  String name;
  String layout;

  ClassRoomsData(this.size, this.id, this.name, this.layout);
  factory ClassRoomsData.fromJson(Map<String, dynamic> json) {
    return ClassRoomsData(
      json['size'] as int,
      json['id'] as int,
      json['name'] as String,
      json['layout'] as String,
    );
  }
}
