// lib/screens/news_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_provider.dart';
import 'news_article.dart';
import 'news_detail_screen.dart';
import 'news_search_delegate.dart'; // <<< Import Search Delegate

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use listen: false to call methods without rebuilding the widget
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top US Headlines'),
        actions: [

          // Bonus: Dark Mode Toggle
          Consumer<NewsProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  icon: Icon(provider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  onPressed: provider.toggleTheme, // Call the toggle function
                );
              }
          ),

          // Bonus: Search Button Integration
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NewsSearchDelegate(), // Launch the search delegate
              );
            },
          ),
        ],
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) { // Using 'provider' to avoid confusion
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator()); // Handle loading state
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!)); // Handle API errors
          }

          final articles = provider.articles;

          // Bonus: Pull-to-Refresh Implementation
          return RefreshIndicator(
            onRefresh: provider.loadHeadlines, // Re-run the API call on pull-down
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return NewsArticleTile(article: article);
              },
            ),
          );
        },
      ),
    );
  }
}

// lib/screens/news_list_screen.dart (Replace the existing NewsArticleTile class)

class NewsArticleTile extends StatelessWidget {
  final NewsArticle article;
  const NewsArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // 1. Wrap the content in a Card for a distinct block appearance.
    return Card(
      elevation: 4, // Adds a shadow effect
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: InkWell( // Use InkWell for the tap effect on the whole card
        onTap: () {
          // Navigate to detailed view
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsDetailScreen(article: article),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. Thumbnail on the Left
              SizedBox(
                width: 100,
                height: 100, // Use a fixed size for the thumbnail area
                child: article.urlToImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40),
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                ),
              ),

              const SizedBox(width: 12),

              // 3. Title and Description on the Right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      article.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    // const SizedBox(height: 4),
                    // // Description
                    // Text(
                    //   article.description ?? 'No description available.',
                    //   maxLines: 4,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: Theme.of(context).textTheme.bodySmall,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}