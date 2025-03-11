import 'dart:convert';
import 'package:customer_feedback_admin/models/feedback.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

class ApiService {
  // ✅ Fetch Feedback List
  Future<List<FeedbackModel>> getFeedback() async {
    final url = Uri.parse(AppConstants.getFeedbackUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppConstants.authTokenKey);

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Raw API Response: ${response.body}"); // ✅ Debugging line

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => FeedbackModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load feedback');
      }
    } catch (e) {
      print("API Error: $e");
      throw Exception('Failed to load feedback');
    }
  }

  // ✅ Delete Feedback
  Future<bool> deleteFeedback(String feedbackId) async {
    final url = Uri.parse("${AppConstants.deleteFeedbackUrl}/$feedbackId");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppConstants.authTokenKey);

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response.statusCode == 200;
  }

  // ✅ Update Feedback
  Future<bool> updateFeedback(String id, String newMessage) async {
    final url = Uri.parse("${AppConstants.updateFeedbackUrl}/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppConstants.authTokenKey);

    print("Sending Update Request to: $url"); // ✅ Debugging Line
    print("Payload: {\"message\": \"$newMessage\"}"); // ✅ Debugging Line

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"message": newMessage}),
    );

    print("Update Response: ${response.statusCode} - ${response.body}"); // ✅ Debugging Line

    return response.statusCode == 200;
  }
}