import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/network/player_service.dart';
import 'package:golfquiz_dtu/network/remote_helper.dart';
import 'package:golfquiz_dtu/providers/friend__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/notification_bubble__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz_dtu/view/pages/bottom_navigation/navigation__container.dart';
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
            child: Consumer<MeProvider>(builder: (context, provider, child) {
              String email;
              if (provider.getPlayer == null ||
                  provider.getPlayer.email == null ||
                  provider.getPlayer.email.isEmpty) {
                email = appLocale().menu__email_error;
              } else {
                email = provider.getPlayer.email;
              }
              return Text('$email', style: appTheme().textTheme.subhead);
            })),

        // Profile
        settingsRow(appLocale().menu__profile_button, () {
          Navigator.pushNamed(context, profileRoute);
        }, false),

        // Friends
        Container(
            child: settingsRow(appLocale().menu__friends_button, () async {
          await enableProgressIndicator("Gathering friends...");

          Player currentPlayer =
              Provider.of<MeProvider>(context, listen: false).getPlayer;

          PlayerService.fetchPlayers(currentPlayer).then((value) async {
            Provider.of<FriendProvider>(context, listen: false)
                .setFriendList(value);

            Navigator.popAndPushNamed(context, friendsRoute);
            return Future.value(true);
          }).catchError((error) async {
            debugPrint("Fetching players error" + error.toString());
            await disableProgressIndicator();
          });
        }, false)),

        SizedBox(height: 40),

        // Log out
        settingsRow(appLocale().menu__log_out_button, () {
          RemoteHelper().emptyProvider(context).then((v) {
            Navigator.pushNamedAndRemoveUntil(context, introRoute,
                ModalRoute.withName(Navigator.defaultRouteName));
          });
        }, false),
        SizedBox(height: BottomNavigationContainer.height + 20)
      ],
    );
  }

  Widget settingsRow(String title, VoidCallback onTab, bool withTop) {
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
