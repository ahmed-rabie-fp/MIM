import 'package:flutter/material.dart';
import 'package:mim_prototype/screens/news_screen/article_item.dart';
import 'package:mim_prototype/screens/news_screen/loading_shimmer_list.dart';
import 'package:mim_prototype/utils/constants.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    _mockGettingDataFromInternet();
    super.didChangeDependencies();
  }

  void _mockGettingDataFromInternet() {
    Future.delayed(Duration(seconds: 2)).then((value) => setState(() {
          _isLoading = false;
        }));
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
              child: _isLoading
                  ? LoadingListShimmer()
                  : ListView.builder(
                      itemBuilder: (context, index) => ArticleItem(
                        article: Constants.newsData.elementAt(index),
                      ),
                      itemCount: Constants.newsData.length,
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
}
