import 'dart:convert';
import 'package:customer_feedback_app/models/feedback.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

class ApiService {
  Future<bool> submitFeedback(String message) async {
    final url = Uri.parse(AppConstants.submitFeedbackUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppConstants.authTokenKey);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"message": message}),
    );

    return response.statusCode == 201;
  }

  Future<List<FeedbackModel>> getFeedback() async {
    final url = Uri.parse(AppConstants.getFeedbackUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppConstants.authTokenKey);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => FeedbackModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load feedback');
    }
  }

  // ✅ New function to update feedback
  Future<bool> updateFeedback(String id, String newMessage) async {
    final url = Uri.parse("${AppConstants.apiBaseUrl}/feedback/update/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppConstants.authTokenKey);

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"message": newMessage}),
    );

    return response.statusCode == 200;
  }
}
