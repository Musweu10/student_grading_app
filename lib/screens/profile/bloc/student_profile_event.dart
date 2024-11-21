import 'package:equatable/equatable.dart';

abstract class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadStudentProfile extends StudentProfileEvent {}

class LoadAttendanceHistory extends StudentProfileEvent {}

class LoadGrades extends StudentProfileEvent {}

class LoadSubjects extends StudentProfileEvent {}

class LoadClasses extends StudentProfileEvent {}
