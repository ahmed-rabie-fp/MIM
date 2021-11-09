import 'package:flutter/material.dart';
import 'package:mim_prototype/custom_widgets/dialogs.dart';
import 'package:mim_prototype/models/article.dart';
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
  bool _isScreenLoading = true;
  bool _isPaginationLoading = false;
  bool _isCurrentTheLastPage = false;
  int _currentPage = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() async {
    await _gettingNewsFromInternet(page: _currentPage);
    //added the pagination function with listener
    _scrollController.addListener(pagination);
    super.didChangeDependencies();
  }

  void pagination() {
    if ((_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) &&
        !_isCurrentTheLastPage) {
      setState(() {
        _isPaginationLoading = true;
        _currentPage += 1;
        //add api for load the more data according to new page
        _gettingNewsFromInternet(page: _currentPage);
      });
    }
  }

  Future<void> _gettingNewsFromInternet({required int page}) async {
    // Fetching data from the endpoint
    try {
      List<dynamic> articles =
          await Provider.of<NewsProvider>(context, listen: false)
              .fetchAndSetCitiesArticles(page);
      if (articles.isEmpty)
        setState(() {
          _isCurrentTheLastPage = true;
        });

      setState(() {
        // Trigger loading in design
        if (page == 1)
          _isScreenLoading = false;
        else
          _isPaginationLoading = false;
      });
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
            Expanded(
              child: (_isScreenLoading)
                  ? LoadingListShimmer()
                  : ListView(
                      controller: _scrollController,
                      children: [
                        const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                        if (Provider.of<NewsProvider>(context)
                            .articles
                            .isNotEmpty)
                          ..._getViewItems(),
                        if (_isPaginationLoading)
                          Container(
                              height: 60,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ))
                      ],
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
