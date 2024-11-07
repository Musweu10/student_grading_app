import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:student_grading_app/screens/profile/widgets/list_tile_widget.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> _logout() async {
    final refreshToken = await _secureStorage.read(key: 'refresh');
    if (refreshToken != null) {
      BlocProvider.of<AuthBloc>(context)
          .add(LogoutEvent(refresh: refreshToken));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("No refresh token found."),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthLogoutSuccess) {
            Navigator.pop(context); // Close the loading dialog
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is AuthFailure) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: ListView(
          children: [
            ListTileWidget(
              iconData: Icons.logout,
              title: "Logout",
              // trailingWidget: const Icon(
              //   size: 15,
              //   Icons.arrow_forward_ios_outlined,
              // ),
              onPressed: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
