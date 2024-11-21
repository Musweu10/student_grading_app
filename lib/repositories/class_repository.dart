// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/class.dart';
// import '../models/subject.dart';
//
// class ClassRepository {
//   final String baseUrl;
//
//   ClassRepository({required this.baseUrl});
//
//   // Fetch class data
//   Future<Class> fetchClass(String classId) async {
//     final response = await http.get(Uri.parse('$baseUrl/classes/$classId'));
//     if (response.statusCode == 200) {
//       return Class.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load class');
//     }
//   }
//
//   // Fetch subjects for a specific class
//   Future<List<Subject>> fetchSubjectsForClass(String classId) async {
//     final response = await http.get(Uri.parse('$baseUrl/classes/$classId/subjects'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       return jsonList.map((json) => Subject.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load subjects');
//     }
//   }
// }
