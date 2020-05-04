import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/localization/appLocalizations.dart';

import 'destination_views/games__page.dart';
import 'destination_views/menu__page.dart';

class BottomNavigationContainer extends StatefulWidget {
  static final double height = 80.0;
  final int _initPage;

  BottomNavigationContainer({int initPage}) : this._initPage = initPage ?? 0;

  @override
  _BottomNavigationContainerState createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer> {
  static final List<Widget> _children = [
    GamesPage(),
    MenuPage(),
  ];
  int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget._initPage;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      child: Stack(children: [
        // CONTENT PAGES
        _children[currentPage],

        // TABBAR
        Positioned(
          top: screenSize.height - BottomNavigationContainer.height,
          child: Container(
            height: BottomNavigationContainer.height,
            width: screenSize.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _iconWrapper(
                    AppLocalization.of(context).bottom_navigation__games, 0),
                _iconWrapper(
                    AppLocalization.of(context).bottom_navigation__menu, 1),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _iconWrapper(String title, int position) {
    bool isActive = currentPage == position;
    var activeColor = Theme.of(context).primaryColor;
    var activeTextColor = Theme.of(context).primaryColorDark;
    var inactiveColor = Theme.of(context).disabledColor;

    var notification = Container(
        padding: EdgeInsets.fromLTRB(30, 3, 0, 0),
        alignment: Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          alignment: Alignment.center,
          height: 15,
          width: 15,
        ));

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          currentPage = position;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 65,
            width: (1 / 4) * MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: isActive ? activeColor : inactiveColor,
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  height: 35,
                  width: 35,
                  child: Icon(
                    _iconDataFromPosition(position),
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: isActive ? activeTextColor : inactiveColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconDataFromPosition(int position) {
    switch (position) {
      case 0:
        return Icons.nature;
      case 1:
        return Icons.menu;
      default:
        return null;
    }
  }
}
