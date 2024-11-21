class Subject {
  final String id;
  final String name;
  final String teacherName;
  final String className;

  Subject({
    required this.id,
    required this.name,
    required this.teacherName,
    required this.className,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      teacherName: json['teacher_name'],
      className: json['class_name'],
    );
  }
}
