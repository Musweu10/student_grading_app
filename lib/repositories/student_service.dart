import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/attendance.dart';
import '../models/class.dart';
import '../models/grade.dart';
import '../models/student_profile.dart';
import '../models/subject.dart';

class StudentRepository {
  final String baseUrl;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  StudentRepository({required this.baseUrl});

  Future<StudentProfile> getStudentProfile() async {
    String? currentAccessToken = await _secureStorage.read(key: 'access');

    // Attempt to fetch the profile
    final response = await http.get(
      Uri.parse('$baseUrl/profile/'),
      headers: {'Authorization': 'Bearer $currentAccessToken'},
    );

    if (response.statusCode == 200) {
      return StudentProfile.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401 && response.body.contains('token_not_valid')) {
      // Token is invalid or expired, attempt to refresh
      try {
        final newAccessToken = await _refreshToken();

        // Retry fetching the profile with the new access token
        final retryResponse = await http.get(
          Uri.parse('$baseUrl/profile/'),
          headers: {'Authorization': 'Bearer $newAccessToken'},
        );

        if (retryResponse.statusCode == 200) {
          return StudentProfile.fromJson(jsonDecode(retryResponse.body));
        } else {
          throw Exception('Failed to load profile after refresh');
        }
      } catch (e) {
        throw Exception('Failed to refresh token: $e');
      }
    } else {
      throw Exception('Failed to load profile: ${response.statusCode} - ${response.body}');
    }
  }

  Future<String> _refreshToken() async {
    String? refreshToken = await _secureStorage.read(key: 'refresh');

    final response = await http.post(
      Uri.parse('$baseUrl/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['access'];

      // Save the new access token securely
      await _secureStorage.write(key: 'access', value: newAccessToken);

      return newAccessToken;
    } else {
      throw Exception('Failed to refresh token: ${response.body}');
    }
  }

  Future<List<Attendance>> getAttendanceHistory() async {
    try {
      final accessToken = await _secureStorage.read(key: 'access');
      final response = await http.get(
        Uri.parse('$baseUrl/attendance/'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Attendance.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load attendance: ${response.body}');
      }
    }catch (e){
      throw Exception('Failed to get attendance: $e');
    }
  }

  Future<List<Grade>> getGrades() async {
    try {
      final accessToken = await _secureStorage.read(key: 'access');
      final response = await http.get(
        Uri.parse('$baseUrl/grades/'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Grade.fromJson(item)).toList();
      } else {
        print(response.body);
        throw Exception('Failed to load grades: ${response.body}');
      }
    } catch (e){
      throw Exception('Failed to load grades: $e');
    }
  }

  Future<List<Subject>> getSubjects() async {
    final accessToken = await _secureStorage.read(key: 'access');
    final response = await http.get(
      Uri.parse('$baseUrl/subjects/'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Subject.fromJson(item)).toList();
    } else {
      print(response.body);
      throw Exception('Failed to load subjects: ${response.body}');
    }
  }

  Future<List<Class>> getClasses() async {
    try {
      final accessToken = await _secureStorage.read(key: 'access');
      final response = await http.get(
        Uri.parse('$baseUrl/class/'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Class.fromJson(item)).toList();
      } else {
        print(response.body);
        throw Exception('Failed to load classes: ${response.body}');
      }
    }catch (e){ throw Exception('Failed to refresh token: $e');
    }
  }
}
