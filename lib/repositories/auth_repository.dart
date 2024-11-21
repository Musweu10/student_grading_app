import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/login_request.dart';
import '../models/registration_request.dart';
import '../models/user.dart';

class AuthRepository {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // final baseUrl = "https://8326-165-58-128-106.ngrok-free.app/api/student";
  final baseUrl = "http://127.0.0.1:8000/api/student";

  Future<User> login(LoginRequest loginRequest) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(loginRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      await _saveTokens(user.access, user.refresh);
      print(response.body);
      return user;
    } else {
      throw Exception('Login failed');
    }
  }

  Future<User> register(RegistrationRequest registrationRequest) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(registrationRequest.toJson()),
    );

    if (response.statusCode == 201) {
      print(response.body);
      final user = User.fromJson(jsonDecode(response.body));
      await _saveTokens(user.access, user.refresh);
      return user;
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }

  Future<void> _saveTokens(String access, String refresh) async {
    await _secureStorage.write(key: 'access', value: access);
    await _secureStorage.write(key: 'refresh', value: refresh);
  }

  // Future<void> logout() async {
  //   // Retrieve both tokens from secure storage
  //   final accessToken = await _secureStorage.read(key: 'access');
  //   final refreshToken = await _secureStorage.read(key: 'refresh');
  //
  //   if (accessToken == null || refreshToken == null) {
  //     throw Exception("Tokens not available for logout");
  //   }
  //
  //   // Send logout request with access token in headers and refresh token in body
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/logout/'),
  //     headers: {
  //       'Authorization': 'Bearer $accessToken',
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode({'refresh': refreshToken}), // Refresh token in the body
  //   );
  //
  //   // Debugging logs
  //   print('Logout Response Status: ${response.statusCode}');
  //   print('Logout Response Body: ${response.body}');
  //
  //   if (response.statusCode == 205) {
  //     // Clear tokens from secure storage upon successful logout
  //     await _secureStorage.deleteAll();
  //   } else {
  //     throw Exception('Logout failed');
  //   }
  // }

  Future<void> logout() async {
    try {
      // Retrieve the refresh token from secure storage
      final refreshToken = await _secureStorage.read(key: 'refresh');

      if (refreshToken == null) {
        throw Exception("Refresh token not available for logout");
      }

      // Send logout request with only the refresh token in the body
      final response = await http.post(
        Uri.parse('$baseUrl/logout/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'refresh': refreshToken}),
      );

      // Debugging logs
      print('Logout Response Status: ${response.statusCode}');
      print('Logout Response Body: ${response.body}');

      if (response.statusCode == 205) {
        // Clear tokens from secure storage upon successful logout
        await _secureStorage.deleteAll();
      } else {
        throw Exception('Logout failed');
      }
    }catch (e){
       e.toString();
    }
  }



}
