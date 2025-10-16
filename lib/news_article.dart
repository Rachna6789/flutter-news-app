// lib/models/news_article.dart

class NewsArticle {
  final String title;
  final String? description;
  final String? urlToImage;
  final String? content; // For the detail screen

  NewsArticle({
    required this.title,
    this.description,
    this.urlToImage,
    this.content,
  });

  // Factory constructor to create a NewsArticle from a JSON map
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      description: json['description'],
      urlToImage: json['urlToImage'],
      content: json['content'],
    );
  }
}