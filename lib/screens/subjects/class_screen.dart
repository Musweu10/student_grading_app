// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../repositories/class_repository.dart';
// import 'bloc/class_bloc.dart';
// import 'subject_screen.dart';
//
// class ClassScreen extends StatelessWidget {
//   final String classId;
//
//   const ClassScreen({super.key, required this.classId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Class Information",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: BlocProvider(
//         create: (context) => ClassBloc(classRepository: ClassRepository(baseUrl: 'http://127.0.0.1:8000/api/student'))
//           ..add(LoadClass(classId: classId)),
//         child: BlocBuilder<ClassBloc, ClassState>(
//           builder: (context, state) {
//             if (state is ClassLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ClassLoaded) {
//               final classData = state.classData;
//               return ListView(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       '${classData.name} - ${classData.teacher}',
//                       style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const Divider(),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: state.subjects.length,
//                     itemBuilder: (context, index) {
//                       final subject = state.subjects[index];
//                       return ListTile(
//                         title: Text(subject.name),
//                         subtitle: Text('Teacher: ${subject.teacher}'),
//                         trailing: const Icon(Icons.arrow_forward_ios),
//                         onTap: () {
//                           // Navigate to Subject Details Screen if needed
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => SubjectsScreen(subjectId: subject.id)));
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               );
//             } else if (state is ClassError) {
//               return Center(child: Text('Error: ${state.error}'));
//             }
//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }
