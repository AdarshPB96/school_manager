class StudentsData {
  int age;
  int id;
  String name;
  String email;

  StudentsData(this.age, this.id, this.name, this.email);
  factory StudentsData.fromJson(Map<String, dynamic> json) {
    return StudentsData(
      json['age'] as int,
      json['id'] as int,
      json['name'] as String,
      json['email'] as String,
    );
  }
}
