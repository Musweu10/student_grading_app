// student_profile.dart
class StudentProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String guardianFirstName;
  final String guardianLastName;
  final String guardianPhoneNumber;

  StudentProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.guardianFirstName,
    required this.guardianLastName,
    required this.guardianPhoneNumber,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      guardianFirstName: json['guardian_first_name'],
      guardianLastName: json['guardian_last_name'],
      guardianPhoneNumber: json['guardian_phone_number'],
    );
  }
}