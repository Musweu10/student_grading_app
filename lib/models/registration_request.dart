class RegistrationRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String guardianFirstName;
  final String guardianLastName;
  final String guardianPhoneNumber;

  RegistrationRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.guardianFirstName,
    required this.guardianLastName,
    required this.guardianPhoneNumber,
  });

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "guardian_first_name": guardianFirstName,
    "guardian_last_name": guardianLastName,
    "guardian_phone_number": guardianPhoneNumber,
  };
}
