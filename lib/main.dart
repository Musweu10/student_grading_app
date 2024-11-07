import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:student_grading_app/repositories/auth_repository.dart';
import 'package:student_grading_app/screens/authentication/login.dart';
import 'package:student_grading_app/screens/authentication/register.dart';
import 'package:student_grading_app/screens/home/home.dart';
import 'package:student_grading_app/screens/navigation/nav.dart';

import 'bloc/auth_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: _authRepository),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Student App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: AppEntryPoint(secureStorage: _secureStorage),
          routes: {
            '/login': (context) => LoginScreen(),
            '/register': (context) => RegistrationScreen(),
            '/home': (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}

class AppEntryPoint extends StatefulWidget {
  final FlutterSecureStorage secureStorage;

  const AppEntryPoint({super.key, required this.secureStorage});

  @override
  State<AppEntryPoint> createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  bool? isAuthenticated;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final accessToken = await widget.secureStorage.read(key: 'access');
    setState(() {
      isAuthenticated = accessToken != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthenticated == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return isAuthenticated! ? const AppNavigationBar() : LoginScreen();
  }
}
