import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import '../profile/bloc/student_profile_bloc.dart';
import '../profile/bloc/student_profile_event.dart';
import '../profile/bloc/student_profile_state.dart';
import '../subjects/widgets/subject_list_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? firstName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _onRefresh(BuildContext context) async {
    // Dispatch the event to reload subjects
    context.read<StudentProfileBloc>().add(LoadSubjects());
    context.read<StudentProfileBloc>().add(LoadClasses());
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('first_name') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()=> _onRefresh(context),
        child: BlocListener<AuthBloc, AuthState>(
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome, ${firstName ?? 'User'}!',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 200,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:   BlocBuilder<StudentProfileBloc, StudentProfileState>(
                    builder: (context, state) {
                      if (state is StudentProfileLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ClassesLoaded) {
                        final classes = state.classes;
                        return ListView.builder(
                          itemCount: classes.length,
                          itemBuilder: (context, index) {
                            final classItem = classes[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              child: ListTile(
                                minTileHeight: 60,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1.5,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text(
                                  'Class: ${classItem.name}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Instructor: ${classItem.teacherName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is StudentProfileError) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(child: Text('Unexpected state'));
                    },
                  ),
                ),


        
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Subject Summary',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                // Wrap GridView in a Container with fixed height
                SizedBox(
                  height: 350, // Adjust height as needed
                  child: BlocBuilder<StudentProfileBloc, StudentProfileState>(
                    builder: (context, state) {
                      if (state is StudentProfileLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SubjectsLoaded) {
                        final subjects = state.subjects;
                        return GridView.builder(
                          itemCount: subjects.length,
                          itemBuilder: (context, index) {
                            final subject = subjects[index];
                            return SubjectListTileWidget(
                              subjectTitle: 'Subject: ${subject.name}',
                              subjectGrade: 'Teacher: ${subject.teacherName}',
                              className: subject.className,
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
