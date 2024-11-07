import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String guardianFirstName;
  final String guardianLastName;
  final String guardianPhoneNumber;

  RegisterEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.guardianFirstName,
    required this.guardianLastName,
    required this.guardianPhoneNumber,
  });
}
class LogoutEvent extends AuthEvent {
  final String refresh;

  LogoutEvent({required this.refresh});
}