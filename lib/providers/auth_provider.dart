import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prenatal_care_app/core/services/auth_service.dart';

/// Authentication Provider
class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  User? _user;
  bool _isLoading = false;
  String? _error;
  String? _userRole; // 'patient' or 'doctor'

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get userRole => _userRole;
  bool get isAuthenticated => _user != null;

  /// Initialize auth state
  void initAuthState() {
    _authService.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  /// Sign up as patient
  Future<void> signUpPatient({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signUpPatient(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      _userRole = 'patient';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sign up as doctor
  Future<void> signUpDoctor({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String specialty,
    required String clinicName,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signUpDoctor(
        email: email,
        password: password,
        name: name,
        phone: phone,
        specialty: specialty,
        clinicName: clinicName,
      );
      _userRole = 'doctor';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sign in
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final credential = await _authService.signIn(
        email: email,
        password: password,
      );
      _user = credential.user;

      // Get user role
      _userRole = await _authService.getUserRole(credential.user!.uid);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.resetPassword(email);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sign out
  Future<void> signOut() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signOut();
      _user = null;
      _userRole = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
