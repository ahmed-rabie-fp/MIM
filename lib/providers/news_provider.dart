import 'package:flutter/material.dart';
import 'package:mim_prototype/models/article.dart';
import 'package:mim_prototype/networking/news_services.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];
  bool isPaginationLoading = false;
  int _currentPage = 1;
  bool _isCurrentPageTheLast = false;

  /// Getter function to return a [copy] of the list
  /// /*
  /// This is to restrict any changes to be done on [_articles] from outside function of this provider class
  /// */
  List<Article> get articles {
    return [..._articles];
  }

  /// Getting all [Articles] from API
  Future<void> fetchArticles() async {
    // If The array of news reached last page
    if (_isCurrentPageTheLast) return;
    // Change state for page loading.
    isPaginationLoading = true;
    print(_currentPage);
    final newsResponse =
        await NewsServices().getNews(page: _currentPage, perPage: 4);
    // If there is no returned data
    if (newsResponse["response"]["data"].isEmpty) {
      isPaginationLoading = false;
      _isCurrentPageTheLast = true;
      notifyListeners();
      return;
    }
    // If this page was fetched successfully
    else
      _currentPage += 1;
    // Looping through API returned data and store each article
    for (var article in newsResponse["response"]["data"]) {
      _articles.add(Article.fromJson(article));
    }
    isPaginationLoading = false;
    notifyListeners();
  }
}
