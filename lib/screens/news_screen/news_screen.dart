import 'package:flutter/material.dart';
import 'package:mim_prototype/custom_widgets/dialogs.dart';
import 'package:mim_prototype/providers/news_provider.dart';
import 'package:mim_prototype/screens/news_screen/article_item.dart';
import 'package:mim_prototype/screens/news_screen/loading_shimmer_list.dart';
import 'package:mim_prototype/utils/app_exceptions.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() async {
    await _gettingNewsFromInternet();
    //added the pagination function with listener
    _scrollController.addListener(pagination);
    super.didChangeDependencies();
  }

  void pagination() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _gettingNewsFromInternet();
    }
    }

  Future<void> _gettingNewsFromInternet() async {
    // Fetching data from the endpoint
    try {
      await Provider.of<NewsProvider>(context, listen: false).fetchArticles();
      // If there is any exception thrown from API helper
    } on FetchDataException catch (exception) {
      await Dialogs.showInformativeDialog(
        context,
        title: "Error in Loading Data from API",
        status: exception.toString(),
      );
    } on BadRequestException catch (exception) {
      await Dialogs.showInformativeDialog(
        context,
        title: "Bad Request!",
        status: exception.toString(),
      );
    } on UnauthorisedException catch (exception) {
      await Dialogs.showInformativeDialog(
        context,
        title: "Unauthorised!",
        status: exception.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Image.asset(
                "assets/logo/logo.png",
                height: 72,
              ),
            ),
            Divider(),
            Consumer<NewsProvider>(
              builder: (__, value, _) => Expanded(
                child: (value.articles.isEmpty)
                    ? LoadingListShimmer()
                    : ListView(
                        controller: _scrollController,
                        children: [
                          const SizedBox(
                            width: 0,
                            height: 0,
                          ),
                          if (value
                              .articles
                              .isNotEmpty)
                            ..._getViewItems(),
                          if (value.isPaginationLoading)
                            Container(
                                height: 60,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ))
                        ],
                      ),
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _getViewItems() {
    List<Widget> articlesView = [];
    Provider.of<NewsProvider>(context).articles.forEach((article) {
      articlesView.add(ArticleItem(article: article));
    });
    return articlesView;
  }
}
