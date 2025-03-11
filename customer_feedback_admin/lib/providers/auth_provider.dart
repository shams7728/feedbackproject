import 'package:customer_feedback_admin/models/admin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../core/constants.dart';

class AuthProvider extends ChangeNotifier {
  Admin? _admin;
  bool _isAuthenticated = false;
  final AuthService _authService = AuthService();

  Admin? get admin => _admin;
  bool get isAuthenticated => _isAuthenticated;

  // ✅ Admin Login using AuthService
  Future<bool> login(String email, String password) async {
    Admin? admin = await _authService.login(email, password);
    if (admin != null) {
      _admin = admin;
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  // ✅ Logout using AuthService
  Future<void> logout() async {
    await _authService.logout();
    _admin = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // ✅ Check Authentication Status
  Future<void> checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppConstants.authTokenKey);
    _isAuthenticated = token != null;
    notifyListeners();
  }
}
