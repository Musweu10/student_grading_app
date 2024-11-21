import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:student_grading_app/repositories/auth_repository.dart';
import 'package:student_grading_app/repositories/student_service.dart';
import 'package:student_grading_app/screens/authentication/login.dart';
import 'package:student_grading_app/screens/authentication/register.dart';
import 'package:student_grading_app/screens/home/home.dart';
import 'package:student_grading_app/screens/navigation/nav.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_bloc.dart';
import 'package:student_grading_app/screens/profile/bloc/student_profile_event.dart';
import 'bloc/auth_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();
  // final ClassRepository _classRepository = ClassRepository(baseUrl: 'http://127.0.0.1:8000/api/student');
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final StudentRepository _studentRepository = StudentRepository(
    // baseUrl: 'https://8326-165-58-128-106.ngrok-free.app/api/student',
    baseUrl: 'http://127.0.0.1:8000/api/student',
  );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository: _authRepository),
          ),
          BlocProvider(
            // create: (context) => StudentProfileBloc(studentService: _studentRepository),
            create: (context) => StudentProfileBloc(studentService: _studentRepository)..add(LoadSubjects()),
          ),
          // BlocProvider(
          //   create: (context) => ClassBloc(classRepository: _classRepository),
          // ),
        ],
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
    _checkAndRefreshToken();
  }

  Future<void> _checkAndRefreshToken() async {
    try {
      final accessToken = await widget.secureStorage.read(key: 'access');
      final refreshToken = await widget.secureStorage.read(key: 'refresh');

      if (accessToken != null) {
        // Validate token by checking expiration
        final isTokenValid = _isTokenValid(accessToken);
        if (isTokenValid) {
          setState(() {
            isAuthenticated = true;
          });
          return;
        }
      }

      // If access token is invalid, refresh it
      if (refreshToken != null) {
        final newAccessToken = await _refreshToken(refreshToken);
        await widget.secureStorage.write(key: 'access', value: newAccessToken);
        setState(() {
          isAuthenticated = true;
        });
        return;
      }
    } catch (e) {
      print('Error in token handling: $e');
    }

    // If all else fails, set as unauthenticated
    setState(() {
      isAuthenticated = false;
    });
  }

  bool _isTokenValid(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final exp = payload['exp'] as int?;
      if (exp == null) return false;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return expiryDate.isAfter(DateTime.now());
    } catch (e) {
      print('Token validation error: $e');
      return false;
    }
  }

  Future<String> _refreshToken(String refreshToken) async {
    const baseUrl = "http://127.0.0.1:8000";
    final response = await http.post(
      Uri.parse('$baseUrl/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access'];
    } else {
      throw Exception('Failed to refresh token: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthenticated == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return isAuthenticated! ? const AppNavigationBar() : LoginScreen();
  }
}
// class AppEntryPoint extends StatefulWidget {
//   final FlutterSecureStorage secureStorage;
//
//   const AppEntryPoint({super.key, required this.secureStorage});
//
//   @override
//   State<AppEntryPoint> createState() => _AppEntryPointState();
// }
//
// class _AppEntryPointState extends State<AppEntryPoint> {
//   bool? isAuthenticated;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkAuthentication();
//   }
//
//   Future<void> _checkAuthentication() async {
//     final accessToken = await widget.secureStorage.read(key: 'access');
//     setState(() {
//       isAuthenticated = accessToken != null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isAuthenticated == null) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     return isAuthenticated! ? const AppNavigationBar() : LoginScreen();
//   }
// }
