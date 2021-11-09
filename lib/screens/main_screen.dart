import 'package:flutter/material.dart';
import 'package:mim_prototype/custom_widgets/bottom_appbar.dart';
import 'package:mim_prototype/screens/chat_screen.dart';
import 'package:mim_prototype/screens/news_screen/news_screen.dart';
import 'package:mim_prototype/screens/services_screen/services_screen.dart';
import 'package:mim_prototype/screens/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin {
  late PageController _controller;
  late AnimationController _animationController;

  @override
  void didChangeDependencies() {
    _controller = PageController(
      initialPage: 0,
      keepPage: true,
    );
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                children: [
                  NewsScreen(),
                  ServicesScreen(),
                  WalletScreen(),
                  ChatScreen(),
                  Container(
                    alignment: Alignment.center,
                    child: Text("More"),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: CustomBottomAppBar(
                  onChanged: _animateToPage,
                )),
          ],
        ),
      ),
    );
  }

  void _animateToPage(int index) {
    if (index == 4)
      popUpMoreMenu();
    else
      _controller.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void popUpMoreMenu() {
    _animationController.forward();
    showGeneralDialog(
      barrierLabel: "menuItems",
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (ctx, __, ___) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: MediaQuery.of(ctx).size.height * 0.5,
            width: MediaQuery.of(ctx).size.width * 0.6,
            margin: EdgeInsets.only(bottom: 80, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildPopUpItem(ctx, "Contact Us", Icons.phone, Colors.indigo,
                    onTap: () {}),
                _buildPopUpItem(ctx, "Send E-Mail", Icons.mail, Colors.indigo,
                    onTap: () {}),
                _buildPopUpItem(ctx, "Settings", Icons.settings, Colors.indigo,
                    onTap: () {}),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    ).then((value) => _animationController.reverse());
  }

  Widget _buildPopUpItem(
      BuildContext ctx, String title, IconData icon, Color color,
      {required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        height: 64,
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              type: MaterialType.transparency,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            CircleAvatar(
              maxRadius: 14,
              minRadius: 14,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(
                icon,
                color: color,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
