class Class {
  final String id;
  final String name;
  final String teacherName;

  Class({
    required this.id,
    required this.name,
    required this.teacherName,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name: json['name'],
      teacherName: json['teacher_name'],
    );
  }
}
