class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String guardianFirstName;
  final String guardianLastName;
  final String guardianPhoneNumber;
  final String access;
  final String refresh;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.guardianFirstName,
    required this.guardianLastName,
    required this.guardianPhoneNumber,
    required this.access,
    required this.refresh,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    guardianFirstName: json['guardian_first_name'],
    guardianLastName: json['guardian_last_name'],
    guardianPhoneNumber: json['guardian_phone_number'],
    access: json['access'],
    refresh: json['refresh'],
  );
}
