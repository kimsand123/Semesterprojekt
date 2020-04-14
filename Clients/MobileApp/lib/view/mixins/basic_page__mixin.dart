import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/localization/appLocalizations.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/gradient_background__component.dart';
import 'package:golfquiz/view/components/loading_dialog__component.dart';
import 'package:progress_dialog/progress_dialog.dart';

mixin BasicPage<Page extends BasePage> on BasePageState<Page> {
  double screenWidth() => MediaQuery.of(context).size.width;
  double screenHeight() => MediaQuery.of(context).size.height;
  ThemeData appTheme() => Theme.of(context);
  AppLocalization appLocale() => AppLocalization.of(context);
  AppBar appBar;
  double contentHeight;
  ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appBar = AppBar(
      actions: <Widget>[action()],
      brightness: Theme.of(context).colorScheme.brightness,
      centerTitle: true,
      elevation: 0,
      textTheme: Theme.of(context).textTheme,
      title: titleWidget(),
      backgroundColor: Colors.transparent,
    );

    contentHeight = screenHeight() - appBar.preferredSize.height - 24;

    return Stack(
      children: <Widget>[
        GradientBackgroundComponent(
          child: Scaffold(
            appBar: appBar,
            body: Scrollbar(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth(),
                  constraints:
                      //TODO: Research if the '45' can be more dynamic
                      BoxConstraints(
                          minHeight: screenHeight() - appBarHeight() - 45),
                  child: body(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void enableProgressIndicator(String message) {
    progressDialog = standardDialog(context, message);
    progressDialog.show();
  }

  void disableProgressIndicator() {
    progressDialog.hide();
  }

  double appBarHeight() => appBar.preferredSize.height;

  Widget body();

  Widget action() => Container();

  Widget titleWidget() {
    return Text(title(), textAlign: TextAlign.center);
  }

  void fieldFocusChange(FocusNode currentFocus, FocusNode newFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(newFocus);
  }
}
