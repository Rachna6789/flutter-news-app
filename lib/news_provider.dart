// lib/providers/news_provider.dart

import 'package:flutter/foundation.dart';
import 'news_article.dart';
import 'api_service.dart';

class NewsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Getters to provide immutable access to the state
  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadHeadlines() async {
    // 1. Start loading
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 2. Fetch data
      _articles = await _apiService.fetchTopHeadlines();
    } catch (e) {
      // 3. Set error message on failure
      _errorMessage = 'Error fetching news: ${e.toString()}';
      if (kDebugMode) {
        print(_errorMessage);
      }
    } finally {
      // 4. Stop loading and notify listeners
      _isLoading = false;
      notifyListeners();
    }
  }
}