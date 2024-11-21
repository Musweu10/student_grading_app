import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_bloc.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_state.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Classes')),
      body:
      BlocBuilder<StudentProfileBloc, StudentProfileState>(
        builder: (context, state) {
          if (state is StudentProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ClassesLoaded) {
            final classes = state.classes;
            return ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final classItem = classes[index];
                return ListTile(
                  title: Text('Class: ${classItem.name}'),
                  subtitle: Text('Instructor: ${classItem.teacherName}'),
                );
              },
            );
          } else if (state is StudentProfileError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
