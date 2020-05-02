import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/avatar__component.dart';
import 'package:golfquiz/view/components/status__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:provider/provider.dart';

class ProfilePage extends BasePage {
  final Player _user;

  ProfilePage({@required Player user}) : this._user = user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage> with BasicPage {
  @override
  Widget action() {
    return Visibility(
      visible: (widget._user == null),
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: IconButton(
          icon: Icon(Icons.edit),
          tooltip: appLocale().edit_profile__title,
          onPressed: () {
            Navigator.pushNamed(context, editProfileRoute);
          },
        ),
      ),
    );
  }

  @override
  Widget body() {
    Player shownUser;
    bool isCurrentPlayer;

    if (widget._user == null) {
      shownUser = Provider.of<UserProvider>(context).getUser;
      isCurrentPlayer = true;
    } else {
      shownUser = widget._user;
      isCurrentPlayer = false;
    }

    return Column(
      children: <Widget>[
        AvatarComponent(
          canEditAvatar: false,
          name: '${shownUser.firstName} ${shownUser.lastName}',
        ),
        Visibility(
          visible: isCurrentPlayer,
          child: Column(
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
                  appLocale().email,
                  '${shownUser.email}',
                  "Username",
                  '${shownUser.username}',
                  appLocale().name,
                  '${shownUser.firstName} + ${shownUser.lastName}',
                  "Study_programme",
                  '${shownUser.studyProgramme}',
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: !isCurrentPlayer,
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight() * 0.05),
              Container(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(appLocale().status,
                    style: Theme.of(context).textTheme.headline.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary)),
              ),
              StatusComponent(
                rowStrings: [
                  "Highscore",
                  '${shownUser.highScore}',
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: !isCurrentPlayer,
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight() * 0.05),
              Container(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(appLocale().profile__game_overview,
                    style: Theme.of(context).textTheme.headline.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ],
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }

  @override
  String title() => '';
}
