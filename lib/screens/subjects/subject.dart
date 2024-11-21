import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/screens/subjects/widgets/subject_list_tile_widget.dart';

import '../profile/bloc/student_profile_bloc.dart';
import '../profile/bloc/student_profile_event.dart';
import '../profile/bloc/student_profile_state.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    // Dispatch the event to reload subjects
    context.read<StudentProfileBloc>().add(LoadSubjects());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subjects",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh:()=> _onRefresh(context),
        child: BlocBuilder<StudentProfileBloc, StudentProfileState>(
          builder: (context, state) {
            if (state is StudentProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SubjectsLoaded) {
              final subjects = state.subjects;
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: ListView.builder(
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return SubjectListTileWidget(
                      subjectTitle: 'Subject: ${subject.name}',
                      subjectGrade: 'Teacher: ${subject.teacherName}',
                      className: subject.className,
                    );
                  },
                ),
              );
            } else if (state is SubjectError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _onRefresh(context),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('Unexpected state'));
          },
        ),
      ),
    );
  }
}
