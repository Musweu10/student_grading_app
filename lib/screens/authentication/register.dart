import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import '../../repositories/auth_repository.dart';
import '../navigation/nav.dart';

class RegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController guardianFirstNameController =
      TextEditingController();
  final TextEditingController guardianLastNameController =
      TextEditingController();
  final TextEditingController guardianPhoneNumberController =
      TextEditingController();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(authRepository: context.read<AuthRepository>()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Student Registration")),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            } else if (state is AuthFailure) {
              Navigator.pop(context); // Close loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.error), backgroundColor: Colors.red),
              );
            } else if (state is AuthSuccess) {
              Navigator.pop(context); // Close loading dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AppNavigationBar()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                    content: Text("Registration successful, Welcome, ${state.user.firstName}!"),
                    backgroundColor: Colors.green),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'First name is required',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Last name is required',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) => value != null && value.contains('@')
                          ? null
                          : 'Enter a valid email',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) => value != null && value.length >= 6
                          ? null
                          : 'Password must be at least 6 characters',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: guardianFirstNameController,
                      decoration: const InputDecoration(
                          labelText: 'Guardian First Name'),
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Guardian first name is required',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: guardianLastNameController,
                      decoration: const InputDecoration(
                          labelText: 'Guardian Last Name'),
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Guardian last name is required',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: guardianPhoneNumberController,
                      decoration: const InputDecoration(
                          labelText: 'Guardian Phone Number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value != null && value.length == 10
                          ? null
                          : 'Enter a valid phone number',
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            RegisterEvent(
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              guardianFirstName:
                                  guardianFirstNameController.text.trim(),
                              guardianLastName: guardianLastNameController.text.trim(),
                              guardianPhoneNumber:
                                  guardianPhoneNumberController.text.trim(),
                            ),
                          );
                        }
                      },
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
