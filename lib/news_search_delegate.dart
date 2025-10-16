// lib/screens/news_search_delegate.dart

import 'package:flutter/material.dart';
import 'news_article.dart';
import 'api_service.dart';
import 'news_screen_list.dart'; // Reuse the NewsArticleTile

class NewsSearchDelegate extends SearchDelegate<NewsArticle> {
  final ApiService apiService = ApiService();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions on the right side of the search bar (e.g., Clear button)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the query text
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon on the left side (e.g., Back button)
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, NewsArticle(title: '')); // Close the search view
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Display results based on the current query
    if (query.isEmpty) {
      return const Center(child: Text("Enter a search term."));
    }

    return FutureBuilder<List<NewsArticle>>(
      future: apiService.searchHeadlines(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No results found."));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return NewsArticleTile(article: snapshot.data![index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types (optional, simple implementation here)
    return const SizedBox.shrink();
  }
}