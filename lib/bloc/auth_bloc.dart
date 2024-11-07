import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_request.dart';
import '../models/registration_request.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    // Register event handlers
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(LoginRequest(
        email: event.email,
        password: event.password,
      ));
      await _saveUserData(user); // Save user data after successful login
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.register(RegistrationRequest(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        guardianFirstName: event.guardianFirstName,
        guardianLastName: event.guardianLastName,
        guardianPhoneNumber: event.guardianPhoneNumber,
      ));
      await _saveUserData(user); // Save user data after successful registration
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(AuthLogoutSuccess());
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }

  // Helper function to save user data in shared preferences and secure storage
  Future<void> _saveUserData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Store user information in SharedPreferences
    await prefs.setString('first_name', user.firstName);
    await prefs.setString('last_name', user.lastName);
    await prefs.setString('email', user.email);
    await prefs.setString('guardian_first_name', user.guardianFirstName);
    await prefs.setString('guardian_last_name', user.guardianLastName);
    await prefs.setString('guardian_phone_number', user.guardianPhoneNumber);

    // Store tokens in secure storage
    await _secureStorage.write(key: 'accessToken', value: user.access);
    await _secureStorage.write(key: 'refreshToken', value: user.refresh);
  }
}
