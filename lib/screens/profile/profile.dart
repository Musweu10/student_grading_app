import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_grading_app/screens/profile/settings.dart';
import 'package:student_grading_app/screens/profile/widgets/list_tile_widget.dart';

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
            iconData: Icons.school,
            title: "View Grades",
            trailingWidget: const Icon(
              size: 15,
              Icons.arrow_forward_ios_outlined,
            ),
            onPressed: () {},
          ),
          ListTileWidget(
            iconData: Icons.show_chart,
            title: "View Attendance",
            trailingWidget: const Icon(
              size: 15,
              Icons.arrow_forward_ios_outlined,
            ),
            onPressed: () {},
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
