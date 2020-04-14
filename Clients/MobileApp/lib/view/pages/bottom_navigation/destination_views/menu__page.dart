import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/notification_bubble__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz/view/pages/bottom_navigation/navigation__container.dart';
import 'package:provider/provider.dart';

class MenuPage extends BasePage {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends BasePageState<MenuPage> with BasicPage {
  @override
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Email title
        Container(
            height: 30,
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Consumer<UserProvider>(builder: (context, provider, child) {
              String email = provider.getUser.email;
              if (provider.getUser == null ||
                  provider.getUser.email == null ||
                  provider.getUser.email.isEmpty) {
                email = appLocale().menu__email_error;
              }
              return Text('$email', style: appTheme().textTheme.subhead);
            })),

        // Profile
        settingsRow(appLocale().menu__profile_button, () {
          Navigator.pushNamed(context, profileRoute);
        }, false),

        // Friends
        Container(
          child: settingsRow(appLocale().menu__friends_button, () {
            Navigator.pushNamed(context, friendsRoute);
          }, false)
        ),

        SizedBox(height: 40),

        // Log out
        settingsRow(appLocale().menu__log_out_button, () {
          Navigator.pushNamedAndRemoveUntil(context, introRoute,
              ModalRoute.withName(Navigator.defaultRouteName));
        }, false),
        SizedBox(height: BottomNavigationContainer.height + 20)
      ],
    );
  }

  Widget settingsRow(
      String title, VoidCallback onTab, bool withTop) {
    var notification = Container(
        padding: EdgeInsets.fromLTRB(30, 3, 0, 0),
        alignment: Alignment.center,
        child: NotificationBubble());

    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: screenWidth(),
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: withTop,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.black45,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              height: 50,
              child: Row(
                children: <Widget>[
                  Text(
                    title,
                    style: appTheme()
                        .textTheme
                        .button
                        .copyWith(color: Colors.black87),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }

  @override
  String title() => appLocale().menu__title;
}
