import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatefulWidget {
  final Function onChanged;

  CustomBottomAppBar({required this.onChanged});

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar>
    with TickerProviderStateMixin {
  int _selectedBarItem = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xffe4d0ae),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
          ),
        ),
        Container(
          height: 75,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomBarIcon(Icons.all_inbox_outlined, "News", 0),
              _buildBottomBarIcon(Icons.design_services, "Services", 1),
              _buildBottomBarIcon(Icons.wallet_travel, "Wallet", 2),
              _buildBottomBarIcon(Icons.message_outlined, "Chat", 3),
              _buildBottomBarIcon(Icons.list, "More", 4)
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildBottomBarIcon(IconData icon, String title, int index) {
    return InkWell(
      onTap: () {
        widget.onChanged(index);
        setState(() {
          _selectedBarItem = index;
        });
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          height: index == _selectedBarItem ? 68 : 40,
          width: index == _selectedBarItem ? 68 : 56,
          padding: EdgeInsets.only(
            top: index == _selectedBarItem ? 0 : 5,
          ),
          margin: EdgeInsets.only(
            bottom: index == _selectedBarItem ? 6 : 0,
          ),
          decoration: BoxDecoration(
            color: index == _selectedBarItem
                ? Theme.of(context).primaryColor
                : null,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: RotationTransition(
            turns: Tween<double>(begin: 0, end: 0.375).animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.ease,
            )),
            child: index == _selectedBarItem
                ? Icon(
                    icon,
                    color: Colors.white,
                    size: 35,
                  )
                : FittedBox(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
          )),
    );
  }

  void popUpAddItemsMenu() {
    _controller.forward();
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
                Hero(
                    tag: "Income",
                    child: _buildPopUpItem(
                        ctx, "Income", Icons.add, Colors.green,
                        onTap: () {})),
                _buildPopUpItem(
                    ctx, "Expense", Icons.minimize, Colors.deepOrange,
                    onTap: () {}),
                _buildPopUpItem(ctx, "Transfer",
                    Icons.arrow_forward_ios_rounded, Colors.indigo,
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
    ).then((value) => _controller.reverse());
  }

  Widget _buildPopUpItem(
      BuildContext ctx, String title, IconData icon, Color color,
      {required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        height: MediaQuery.of(ctx).size.height * 0.1,
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
