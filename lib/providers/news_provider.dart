import 'package:flutter/material.dart';
import 'package:mim_prototype/models/article.dart';
import 'package:mim_prototype/networking/news_services.dart';

class NewsProvider with ChangeNotifier {

  List<Article> _articles = [];

  /// Getter function to return a [copy] of the list
  /// /*
  /// This is to restrict any changes to be done on [_articles] from outside function of this provider class
  /// */
  List<Article> get articles {
    return [..._articles];
  }

  /// Getting all [Articles] from API
  Future<List<dynamic>> fetchAndSetCitiesArticles(page) async {
    final newsResponse = await NewsServices().getNews(page : page, perPage: 4);
    // Initiate an empty articles list to start storing
    List<Article> articles = _articles;
    // Looping through API returned data and store each article
    for (var article in newsResponse["response"]["data"]) {
      articles.add(Article.fromJson(article));
    }
    // Set [_articles] to have the returned result.
    _articles = articles;
    return newsResponse["response"]["data"];
  }
}