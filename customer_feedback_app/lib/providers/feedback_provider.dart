import 'package:flutter/material.dart';
import '../models/feedback.dart';
import '../services/api_service.dart';

class FeedbackProvider extends ChangeNotifier {
  List<FeedbackModel> _feedbackList = [];
  bool _isLoading = false;

  List<FeedbackModel> get feedbackList => _feedbackList;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  // ✅ Fetch Feedback from API
  Future<void> fetchFeedback() async {
    _isLoading = true;
    notifyListeners();

    try {
      _feedbackList = await _apiService.getFeedback();
    } catch (e) {
      print("Error fetching feedback: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ Sort Feedback (Ascending / Descending)
  void sortFeedback(bool isAscending) {
    _feedbackList.sort((a, b) => isAscending
        ? a.createdAt.compareTo(b.createdAt) // Ascending
        : b.createdAt.compareTo(a.createdAt) // Descending
    );
    notifyListeners();
  }

  // ✅ Submit Feedback
  Future<bool> submitFeedback(String message) async {
    bool success = await _apiService.submitFeedback(message);
    if (success) {
      fetchFeedback(); // Refresh feedback after submission
    }
    return success;
  }

  // ✅ Edit Feedback
  Future<bool> editFeedback(String id, String newMessage) async {
    bool success = await _apiService.updateFeedback(id, newMessage);
    if (success) {
      int index = _feedbackList.indexWhere((item) => item.id == id);
      if (index != -1) {
        _feedbackList[index] = FeedbackModel(
          id: id,
          user: _feedbackList[index].user,
          message: newMessage,
          status: _feedbackList[index].status,
          createdAt: _feedbackList[index].createdAt, // Keep original date
        );
        notifyListeners();
      }
    }
    return success;
  }
}
