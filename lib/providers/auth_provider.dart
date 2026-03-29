import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._authService);

  final AuthService _authService;
  bool isLoading = false;
  String? error;

  Stream<User?> get authState => _authService.authStateChanges();
  User? get currentUser => _authService.currentUser;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await _authService.login(email: email.trim(), password: password.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      error = e.message ?? 'Login failed';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await _authService.register(email: email.trim(), password: password.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      error = e.message ?? 'Registration failed';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
