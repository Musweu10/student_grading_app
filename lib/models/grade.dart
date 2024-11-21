class Grade {
  final String id;
  final String subjectName;
  final String subjectTeacher;
  final double midTermScore;
  final double finalExamScore;
  final double totalScore;

  Grade({
    required this.id,
    required this.subjectName,
    required this.subjectTeacher,
    required this.midTermScore,
    required this.finalExamScore,
    required this.totalScore,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      subjectName: json['subject_name'],
      subjectTeacher: json['subject_teacher'],
      midTermScore: json['mid_term_score'],
      finalExamScore: json['final_exam_score'],
      totalScore: json['total_score'],
    );
  }
}
