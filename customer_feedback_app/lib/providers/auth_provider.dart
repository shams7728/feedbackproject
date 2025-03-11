import 'package:customer_feedback_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../core/constants.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isAuthenticated = false;

  UserModel? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  final AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    _user = await _authService.login(email, password);
    _isAuthenticated = _user != null;
    notifyListeners();
  }

  Future<bool> register(String name, String email, String password) async {
    return await _authService.register(name, email, password);
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppConstants.authTokenKey);
    _isAuthenticated = token != null;
    notifyListeners();
  }
}
