import 'package:flutter/material.dart';
import 'package:student_grading_app/screens/subjects/widgets/subject_list_tile_widget.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

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
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Your Subjects for this term',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SubjectListTileWidget(
            subjectTitle: "Physics",
            subjectGrade: "Grade 11",
            onPressed: () {},
          ),
          SubjectListTileWidget(
            subjectTitle: "Chemistry",
            subjectGrade: "Grade 11",
            onPressed: () {},
          ),
          SubjectListTileWidget(
            subjectTitle: "Science",
            subjectGrade: "Grade 11",
            onPressed: () {},
          ),
          SubjectListTileWidget(
            subjectTitle: "Mathematics",
            subjectGrade: "Grade 11",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
