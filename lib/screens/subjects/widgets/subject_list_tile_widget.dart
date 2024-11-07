import 'package:flutter/material.dart';

class SubjectListTileWidget extends StatelessWidget {
  final String subjectTitle;
  final String subjectGrade;
  final VoidCallback onPressed;

  const SubjectListTileWidget(
      {super.key,
      required this.subjectTitle,
      required this.subjectGrade,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: ListTile(
        splashColor: theme.splashColor,
        minTileHeight: 60,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.5,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          subjectTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subjectGrade),
        onTap: onPressed,
      ),
    );
  }
}
