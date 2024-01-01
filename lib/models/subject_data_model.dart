class SubjectData {
  int credits;
  int id;
  String name;
  String teacher;

  SubjectData(this.credits, this.id, this.name, this.teacher);
  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(
      json['credits'] as int,
      json['id'] as int,
      json['name'] as String,
      json['teacher'] as String,
    );
  }
}
