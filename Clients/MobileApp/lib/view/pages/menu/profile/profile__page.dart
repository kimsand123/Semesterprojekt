import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/avatar__component.dart';
import 'package:golfquiz_dtu/view/components/status__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';
import 'package:provider/provider.dart';

class ProfilePage extends BasePage {
  final Player _player;

  ProfilePage({@required Player user}) : this._player = user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage> with BasicPage {
  @override
  Widget body() {
    Player shownPlayer;

    if (widget._player == null) {
      shownPlayer = Provider.of<MeProvider>(context, listen: false).getPlayer;
    } else {
      shownPlayer = widget._player;
    }

    return Column(
      children: <Widget>[
        AvatarComponent(
          canEditAvatar: false,
          name: '${shownPlayer.username}',
        ),
        Column(
          children: <Widget>[
            SizedBox(height: screenHeight() * 0.05),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(appLocale().profile__title,
                  style: Theme.of(context).textTheme.headline.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
            StatusComponent(
              rowStrings: [
                "First Name",
                '${shownPlayer.firstName}',
                "Last Name",
                '${shownPlayer.lastName}',
                "Username",
                '${shownPlayer.username}',
                "Email",
                '${shownPlayer.email}',
                "Study Programme",
                '${shownPlayer.studyProgramme}',
                "Highscore",
                '${shownPlayer.highScore}',
              ],
            ),
          ],
        ),
        SizedBox(height: 20)
      ],
    );
  }

  @override
  String title() => '';
}
