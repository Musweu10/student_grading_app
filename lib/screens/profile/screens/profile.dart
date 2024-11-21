import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_grading_app/screens/profile/screens/attendance_screen.dart';
import 'package:student_grading_app/screens/profile/screens/class_screen.dart';
import 'package:student_grading_app/screens/profile/screens/profile_details.dart';
import 'package:student_grading_app/screens/profile/screens/settings.dart';
import 'package:student_grading_app/screens/profile/widgets/list_tile_widget.dart';
import 'package:student_grading_app/screens/subjects/subject_screen.dart';

import '../bloc/student_profile_bloc.dart';
import '../bloc/student_profile_event.dart';
import 'grades_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? firstName;
  String? lasttName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('first_name') ?? 'User';
      lasttName = prefs.getString('last_name') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CircleAvatar(
              foregroundColor: Colors.deepPurple,
              // foregroundImage: NetworkImage(
              //   "https://images.unsplash.com/photo-1522529599102-193c0d76b5b6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmxhY2slMjBwZXJzb258ZW58MHx8MHx8fDA%3D",
              // ),
              // radius: 20,
              maxRadius: 65,
              minRadius: 50,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Hello, ${firstName ?? 'User'} ${lasttName ?? 'User'}",
                style: const TextStyle(
                  color: Color(0xff38383a),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTileWidget(
            iconData: Icons.person,
            title: "View Profile Information",
            trailingWidget: const Icon(
              size: 15,
              Icons.arrow_forward_ios_outlined,
            ),
            onPressed: () {
              // Dispatch the LoadStudentProfile event
              context.read<StudentProfileBloc>().add(LoadStudentProfile());

              // Navigate to the StudentProfileScreen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StudentProfileDetailsScreen(),
                ),
              );
            },
          ),

          ListTileWidget(
            iconData: Icons.school,
            title: "View Grades",
            trailingWidget: const Icon(
              size: 15,
              Icons.arrow_forward_ios_outlined,
            ),
            onPressed: () {
              context.read<StudentProfileBloc>().add(LoadGrades());
              // Navigate to GradesScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GradesScreen()),
              );
            },
          ),
          ListTileWidget(
            iconData: Icons.show_chart,
            title: "View Attendance",
            trailingWidget: const Icon(
              size: 15,
              Icons.arrow_forward_ios_outlined,
            ),
            onPressed: () {
              context.read<StudentProfileBloc>().add(LoadAttendanceHistory());
              // Navigate to AttendanceScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AttendanceHistoryScreen()),
              );
            },
          ),
          ListTileWidget(
            iconData: Icons.show_chart,
            title: "View Subjects",
            trailingWidget: const Icon(
              size: 15,
              Icons.arrow_forward_ios_outlined,
            ),
            onPressed: () {
              context.read<StudentProfileBloc>().add(LoadSubjects());
              // Navigate to AttendanceScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SubjectsScreen()),
              );
            },
          ), ListTileWidget(
            iconData: Icons.show_chart,
            title: "View My Class",
            trailingWidget: const Icon(
              size: 15,
              Icons.arrow_forward_ios_outlined,
            ),
            onPressed: () {
              context.read<StudentProfileBloc>().add(LoadClasses());
              // Navigate to AttendanceScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ClassesScreen()),
              );
            },
          ),
          ListTileWidget(
            iconData: Icons.settings,
            title: "Settings",
            trailingWidget: const Icon(
              size: 15,
              Icons.arrow_forward_ios_outlined,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
