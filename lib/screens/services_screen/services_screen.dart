import 'package:flutter/material.dart';
import 'package:mim_prototype/custom_widgets/custom_button.dart';
import 'package:mim_prototype/screens/services_screen/loading_shimmer_list.dart';
import 'package:mim_prototype/utils/constants.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
            child: Container(
              child: _isLoading
                  ? LoadingListShimmer()
                  : ListView.builder(
                      itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16)),
                            child: ExpansionTile(
                              title: Text(
                                Constants.servicesData.elementAt(index).title,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w800),
                              ),
                              subtitle: Text(Constants.servicesData
                                  .elementAt(index)
                                  .subtitle),
                              initiallyExpanded: false,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Column(
                                    children: [
                                      Text(
                                        Constants.servicesData
                                            .elementAt(index)
                                            .description,
                                        style: TextStyle(
                                            color: Colors.grey.shade800),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: CustomButton(
                                                text: "Start Service",
                                                isHighlighted: true,
                                              )),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          CustomButton(
                                            text: "Rating",
                                            isHighlighted: false,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      itemCount: 4,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
