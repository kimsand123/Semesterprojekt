import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/main.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/auth__components/auth_button__component.dart';
import 'package:golfquiz_dtu/view/components/auth__components/language_button__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';

class IntroPage extends BasePage {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends BasePageState<IntroPage> with BasicPage {
  @override
  String title() => appLocale().auth_intro__title;

  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth() * 0.2),
          child: Image(image: AssetImage('assets/images/golf_intro_logo.png')),
        ),
        Column(children: [
          AuthButtonComponent(
            margin: EdgeInsets.only(top: 20.0),
            text: Text(appLocale().auth_intro__login_button,
                style: appTheme().textTheme.button),
            onPressed: () {
              Navigator.pushNamed(context, loginRoute);
            },
          ),
        ]),
      ],
    );
  }
}
