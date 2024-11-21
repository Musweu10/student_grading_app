// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../models/attendance.dart';
// import '../bloc/student_profile_bloc.dart';
// import '../bloc/student_profile_event.dart';
// import '../bloc/student_profile_state.dart';
//
// class AttendanceScreen extends StatelessWidget {
//   const AttendanceScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Access the StudentProfileBloc to load attendance data
//     context.read<StudentProfileBloc>().add(LoadAttendanceHistory());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Attendance'),
//       ),
//       body: BlocBuilder<StudentProfileBloc, StudentProfileState>(
//         builder: (context, state) {
//           if (state is StudentProfileLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is AttendanceHistoryLoaded) {
//             return ListView.builder(
//               itemCount: state.attendanceList.length,
//               itemBuilder: (context, index) {
//                 final Attendance attendance = state.attendanceList[index];
//                 return ListTile(
//                   title: Text('Class: ${attendance.classAssigned}'),
//                   subtitle: Text(
//                     'Date: ${attendance.date}\n'
//                         'Present: ${attendance.isPresent ? "Yes" : "No"}',
//                   ),
//                 );
//               },
//             );
//           } else if (state is StudentProfileError) {
//             return Center(child: Text(state.message));
//           }
//           return const Center(child: Text('No attendance records found.'));
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
import 'package:student_grading_app/models/attendance.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance History')),
      body: BlocBuilder<StudentProfileBloc, StudentProfileState>(
        builder: (context, state) {
          if (state is StudentProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AttendanceHistoryLoaded) {
            final attendanceList = state.attendanceList;
            return ListView.builder(
              itemCount: attendanceList.length,
              itemBuilder: (context, index) {
                final attendance = attendanceList[index];
                return ListTile(
                  title: Text('Grade: ${attendance.className}'),
                  subtitle: Text('Date: ${attendance.date}'),
                  trailing: Text('Status: ${attendance.isPresent}'),
                );
              },
            );
          } else if (state is AttendanceHistoryError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
