import 'package:equatable/equatable.dart';
import '../../../models/attendance.dart';
import '../../../models/grade.dart';
import '../../../models/subject.dart';
import '../../../models/class.dart';
import '../../../models/student_profile.dart';

abstract class StudentProfileState extends Equatable {
  const StudentProfileState();

  @override
  List<Object> get props => [];
}

class StudentProfileInitial extends StudentProfileState {}

class StudentProfileLoading extends StudentProfileState {}

class StudentProfileLoaded extends StudentProfileState {
  final StudentProfile profile;
  const StudentProfileLoaded({required this.profile});
}

class AttendanceHistoryLoaded extends StudentProfileState {
  final List<Attendance> attendanceList;
  const AttendanceHistoryLoaded({required this.attendanceList});
}

class GradesLoaded extends StudentProfileState {
  final List<Grade> grades;
  const GradesLoaded({required this.grades});
}

class SubjectsLoaded extends StudentProfileState {
  final List<Subject> subjects;
  const SubjectsLoaded({required this.subjects});
}

class ClassesLoaded extends StudentProfileState {
  final List<Class> classes;
  const ClassesLoaded({required this.classes});
}

class StudentProfileError extends StudentProfileState {
  final String message;
  const StudentProfileError({required this.message});
}
class ClassError extends StudentProfileState {
  final String message;
  const ClassError({required this.message});
}
class GradesError extends StudentProfileState {
  final String message;
  const GradesError({required this.message});
}

class SubjectError extends StudentProfileState {
  final String message;
  const SubjectError({required this.message});
}
class AttendanceHistoryError extends StudentProfileState {
  final String message;
  const AttendanceHistoryError({required this.message});
}
