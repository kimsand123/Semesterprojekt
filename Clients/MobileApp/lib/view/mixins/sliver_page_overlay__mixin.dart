import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/localization/appLocalizations.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';

mixin SliverPageOverlay<Page extends BasePage> on BasePageState<Page> {
  double screenWidth() => MediaQuery.of(context).size.width;
  double screenHeight() => MediaQuery.of(context).size.height;
  ThemeData appTheme() => Theme.of(context);
  AppLocalization appLocale() => AppLocalization.of(context);
  SliverAppBar appBar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appBar = SliverAppBar(
      actions: <Widget>[action()],
      expandedHeight: sliverAppBarHeight(),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ]),
            borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: appBarContainer(),
        ),
      ),
      brightness: Theme.of(context).colorScheme.brightness,
      pinned: true,
      floating: true,
      stretch: true,
      elevation: 0,
      textTheme: Theme.of(context).textTheme,
    );

    return Stack(
      children: [ 
        Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(slivers: [
            appBar,
            SliverToBoxAdapter(
              child: Container(
                width: screenWidth(),
                constraints:
                    BoxConstraints(minHeight: screenHeight() - appBarHeight()),
                child: body(),
              ),
            ),
          ]),
      ),
      bottomBar(),
      backdrop(),
      overlay()
    ]);
  }

  double appBarHeight() => 80;

  Widget bottomBar() => Container();

  Widget backdrop() => Container();

  Widget overlay() => Container();

  double sliverAppBarHeight() => MediaQuery.of(context).size.height * 0.35;

  Widget body();

  Widget appBarContainer() => Container();

  Widget action() => Container();

  Widget titleWidget() {
    return Text(title(), textAlign: TextAlign.center);
  }
}