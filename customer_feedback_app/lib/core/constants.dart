class AppConstants {
  static const String apiBaseUrl = "http://localhost:5000/api";

  // Authentication Endpoints
  static const String loginUrl = "$apiBaseUrl/auth/login";
  static const String registerUrl = "$apiBaseUrl/auth/register";

  // Feedback Endpoints
  static const String submitFeedbackUrl = "$apiBaseUrl/feedback/add";
  static const String getFeedbackUrl = "$apiBaseUrl/feedback/list";

  // Auth Token Key
  static const String authTokenKey = "auth_token";
}
