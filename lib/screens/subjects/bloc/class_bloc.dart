// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import '../../../models/class.dart';
// import '../../../models/subject.dart';
// import '../../../repositories/class_repository.dart';
//
// // State for BLoC
// abstract class ClassState extends Equatable {
//   const ClassState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class ClassLoading extends ClassState {}
//
// class ClassLoaded extends ClassState {
//   final Class classData;
//   final List<Subject> subjects;
//
//   const ClassLoaded({required this.classData, required this.subjects});
//
//   @override
//   List<Object> get props => [classData, subjects];
// }
//
// class ClassError extends ClassState {
//   final String error;
//
//   const ClassError({required this.error});
//
//   @override
//   List<Object> get props => [error];
// }
//
// // Events for BLoC
// abstract class ClassEvent extends Equatable {
//   const ClassEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class LoadClass extends ClassEvent {
//   final String classId;
//
//   const LoadClass({required this.classId});
//
//   @override
//   List<Object> get props => [classId];
// }
//
// // BLoC implementation
// class ClassBloc extends Bloc<ClassEvent, ClassState> {
//   final ClassRepository classRepository;
//
//   ClassBloc({required this.classRepository}) : super(ClassLoading()) {
//     on<LoadClass>((event, emit) async {
//       emit(ClassLoading());
//       try {
//         final classData = await classRepository.fetchClass(event.classId);
//         final subjects = await classRepository.fetchSubjectsForClass(event.classId);
//         emit(ClassLoaded(classData: classData, subjects: subjects));
//       } catch (e) {
//         emit(ClassError(error: e.toString()));
//       }
//     });
//   }
// }
