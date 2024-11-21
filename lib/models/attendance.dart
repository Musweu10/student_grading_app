class Attendance {
  final String id;
  final String className;
  final String date;
  final bool isPresent;

  Attendance({
    required this.id,
    required this.className,
    required this.date,
    required this.isPresent,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      className: json['class_name'],
      date: json['date'],
      isPresent: json['is_present'],
    );
  }
}
