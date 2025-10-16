// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_article.dart';

class ApiService {
  // REPLACE WITH YOUR ACTUAL KEY
  static const String apiKey = 'c1772f8d4c1b457a9ccede38a27a1e20';
  static const String baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'; //

  Future<List<NewsArticle>> fetchTopHeadlines() async {
    final response = await http.get(Uri.parse(baseUrl));

    // Handle API errors [cite: 11, 27]
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List articlesJson = jsonResponse['articles'];

      return articlesJson
          .map((json) => NewsArticle.fromJson(json))
          .where((article) => article.urlToImage != null && article.description != null) // Filter for required fields
          .toList();
    } else {
      // Throw an exception if the API request failed
      throw Exception('Failed to load news. Status Code: ${response.statusCode}'); //
    }
  }


  Future<List<NewsArticle>> searchHeadlines(String query) async {
    final searchUrl =
        'https://newsapi.org/v2/everything?q=$query&sortBy=relevancy&apiKey=$apiKey';

    final response = await http.get(Uri.parse(searchUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List articlesJson = jsonResponse['articles'];

      return articlesJson
          .map((json) => NewsArticle.fromJson(json))
          .where((article) => article.urlToImage != null && article.description != null)
          .toList();
    } else {
      throw Exception('Failed to search news. Status Code: ${response.statusCode}');
    }
  }
}
