// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../models/grade.dart';
// import '../bloc/student_profile_bloc.dart';
// import '../bloc/student_profile_event.dart';
// import '../bloc/student_profile_state.dart';
//
//
// class GradesScreen extends StatelessWidget {
//   const GradesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Access the StudentProfileBloc to load grades
//     context.read<StudentProfileBloc>().add(LoadGrades());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Grades'),
//       ),
//       body: BlocBuilder<StudentProfileBloc, StudentProfileState>(
//         builder: (context, state) {
//           if (state is StudentProfileLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is GradesLoaded) {
//             return ListView.builder(
//               itemCount: state.grades.length,
//               itemBuilder: (context, index) {
//                 final Grade grade = state.grades[index];
//                 return ListTile(
//                   title: Text('Subject: ${grade.subject}'),
//                   subtitle: Text(
//                     'Midterm: ${grade.midTermScore}\n'
//                         'Final: ${grade.finalExamScore}\n'
//                         'Total: ${grade.totalScore}',
//                   ),
//                 );
//               },
//             );
//           } else if (state is StudentProfileError) {
//             return Center(child: Text(state.message));
//           }
//           return const Center(child: Text('No grades found.'));
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_bloc.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_state.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_event.dart';
import 'package:student_grading_app/models/grade.dart';

class GradesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grades')),
      body: BlocBuilder<StudentProfileBloc, StudentProfileState>(
        builder: (context, state) {
          if (state is StudentProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GradesLoaded) {
            final grades = state.grades;
            return ListView.builder(
              itemCount: grades.length,
              itemBuilder: (context, index) {
                final grade = grades[index];
                return ListTile(
                  title: Text('Subject: ${grade.subjectName}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Teacher: ${grade.subjectTeacher}'),
                      Text('Midterm Score: ${grade.midTermScore}'),
                      Text('Final Exam Score: ${grade.finalExamScore}'),
                      Text('Total Score: ${grade.totalScore}'),
                    ],
                  ),
                );
              },
            );

          } else if (state is GradesError) {
            print(state.message.toString());
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
