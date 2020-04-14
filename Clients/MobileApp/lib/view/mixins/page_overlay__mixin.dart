import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/gradient_background__component.dart';

mixin PageOverlay<Page extends BasePage> on BasePageState<Page> {
  screenWidth() => MediaQuery.of(context).size.width;
  screenHeight() => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      actions: <Widget>[action()],
      centerTitle: true,
      elevation: 0,
      textTheme: Theme.of(context).textTheme,
      title: Text(title(), textAlign: TextAlign.center),
      backgroundColor: Colors.transparent,
    );

    return GradientBackgroundComponent(
      child: Stack(children: [
        Scaffold(
          appBar: appbar,
          body: SingleChildScrollView(
            child: Container(
              width: screenWidth(),
              constraints: BoxConstraints(
              minHeight: screenHeight() -
                    appbar.preferredSize.height -
                    kToolbarHeight),
              child: body(),
            )
          ),
        ),
        backdrop(),
        overlay()
      ]),
    );
  }

  Widget backdrop();

  Widget overlay();

  Widget body();

  Widget action() => Container();
}
