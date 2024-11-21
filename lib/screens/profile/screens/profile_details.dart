import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_bloc.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_state.dart';
import 'package:student_grading_app/models/student_profile.dart';

class StudentProfileDetailsScreen extends StatelessWidget {
  const StudentProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: BlocBuilder<StudentProfileBloc, StudentProfileState>(
        builder: (context, state) {
          if (state is StudentProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentProfileLoaded) {
            return _buildProfileDetails(state.profile);
          } else if (state is StudentProfileError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No profile data available.'));
          }
        },
      ),
    );
  }

  Widget _buildProfileDetails(StudentProfile profile) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('First Name', profile.firstName),
          _buildDetailRow('Last Name', profile.lastName),
          _buildDetailRow('Email', profile.email),
          const SizedBox(height: 20),
          const Text(
            'Guardian Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildDetailRow('Guardian First Name', profile.guardianFirstName),
          _buildDetailRow('Guardian Last Name', profile.guardianLastName),
          _buildDetailRow('Guardian Phone Number', profile.guardianPhoneNumber),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
