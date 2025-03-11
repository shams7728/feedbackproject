class AppConstants {
  static const String apiBaseUrl = "http://localhost:5000/api"; // Update this to your server URL if hosted

  // Auth Endpoints
  static const String loginUrl = "$apiBaseUrl/auth/login";

  // Feedback Endpoints
  static const String getFeedbackUrl = "$apiBaseUrl/feedback/list";
  static const String addFeedbackUrl = "$apiBaseUrl/feedback/add";
  static const String updateFeedbackUrl = "$apiBaseUrl/admin/feedback"; // Append /{id} in API calls
  static const String deleteFeedbackUrl = "$apiBaseUrl/admin/feedback"; // Append /{id} in API calls

  // Token Key for Shared Preferences
  static const String authTokenKey = 'auth_token';
}
