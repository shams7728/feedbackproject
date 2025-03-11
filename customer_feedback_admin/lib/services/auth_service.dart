import 'dart:convert';
import 'package:customer_feedback_admin/models/admin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

class AuthService {
  Future<Admin?> login(String email, String password) async {
    final url = Uri.parse(AppConstants.loginUrl);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Admin admin = Admin.fromJson(data);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.authTokenKey, admin.token);

        return admin;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.authTokenKey);
  }
}
