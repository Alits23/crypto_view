import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/model/cryptoList.dart';
import 'BookMarkPage.dart';
import 'CoinListPage.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key, this.cryptoList});
  List<Crypto>? cryptoList;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool darkTheme = false;
  int page = 0;
  List<Crypto>? cryptoList;
  @override
  void initState() {
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme ? ThemeData.light() : ThemeData.dark(),
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: page,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.add, size: 30, color: Colors.white),
            Icon(Icons.bookmark, size: 30, color: Colors.white),
          ],
          color: darkTheme ? Colors.blueAccent : Colors.grey[800]!,
          buttonBackgroundColor:
              darkTheme ? Colors.blueAccent : Colors.grey[800]!,
          backgroundColor: darkTheme ? Colors.white : Colors.grey[850]!,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        // AppBar
        appBar: AppBar(
          backgroundColor: darkTheme ? Colors.blueAccent : Colors.grey[800],
          title: Text(
            'Crypto',
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'mh',
              letterSpacing: 2.0,
              color: darkTheme ? Colors.white : Colors.amber,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            alignment: Alignment.centerRight,
            splashRadius: 0.1,
            onPressed: () {
              setState(() {
                darkTheme = !darkTheme;
              });
            },
            icon: getIconTheme(),
          ),
        ),
        body: WillPopScope(
          child: Container(
            child: getSelectedWidget(index: page),
          ),
          onWillPop: () async {
            SystemNavigator.pop();
            return false;
          },
        ),
      ),
    );
  }

  Widget getSelectedWidget({required index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = CoinListPage(
          cryptoList: cryptoList,
        );
        break;
      case 1:
        widget = BookMarkPage();
        break;
      default:
        widget = BookMarkPage();
        break;
    }
    return widget;
  }

  Widget getIconTheme() {
    if (darkTheme) {
      return Icon(
        Icons.light_mode,
        color: Colors.white,
      );
    } else {
      return Icon(
        Icons.dark_mode_outlined,
        color: Colors.amber,
      );
    }
  }
}
