import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_event.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_state.dart';
import '../../../repositories/student_service.dart';

class StudentProfileBloc extends Bloc<StudentProfileEvent, StudentProfileState> {
  final StudentRepository studentService;

  StudentProfileBloc({required this.studentService}) : super(StudentProfileInitial()) {
    on<LoadStudentProfile>(_onLoadStudentProfile);
    on<LoadAttendanceHistory>(_onLoadAttendanceHistory);
    on<LoadGrades>(_onLoadGrades);
    on<LoadSubjects>(_onLoadSubjects);
    on<LoadClasses>(_onLoadClasses);
  }

  Future<void> _onLoadStudentProfile(
      LoadStudentProfile event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(StudentProfileLoading());
    try {
      final profile = await studentService.getStudentProfile();
      emit(StudentProfileLoaded(profile: profile));
    } catch (e) {
      emit(StudentProfileError(message: 'Failed to load profile: ${e.toString()}'));
    }
  }

  Future<void> _onLoadAttendanceHistory(
      LoadAttendanceHistory event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(StudentProfileLoading());
    try {
      final attendance = await studentService.getAttendanceHistory();
      emit(AttendanceHistoryLoaded(attendanceList: attendance));
    } catch (e) {
      emit(AttendanceHistoryError(message: 'Failed to load attendance: ${e.toString()}'));
    }
  }

  Future<void> _onLoadGrades(
      LoadGrades event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(StudentProfileLoading());
    try {
      final grades = await studentService.getGrades();
      emit(GradesLoaded(grades: grades));
    } catch (e) {
      emit(GradesError(message: 'Failed to load grades: ${e.toString()}'));
    }
  }

  Future<void> _onLoadSubjects(
      LoadSubjects event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(StudentProfileLoading());
    try {
      final subjects = await studentService.getSubjects();
      emit(SubjectsLoaded(subjects: subjects));
    } catch (e) {
      emit(SubjectError(message: 'Failed to load subjects: ${e.toString()}'));
    }
  }

  Future<void> _onLoadClasses(
      LoadClasses event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(StudentProfileLoading());
    try {
      final classes = await studentService.getClasses();
      emit(ClassesLoaded(classes: classes));
    } catch (e) {
      emit(ClassError(message: 'Failed to load classes: ${e.toString()}'));
    }
  }
}
