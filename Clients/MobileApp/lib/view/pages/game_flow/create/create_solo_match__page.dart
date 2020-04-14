import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/providers/current_game__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/auth__components/auth_button__component.dart';
import 'package:golfquiz/view/components/custom_picker__component.dart';
import 'package:golfquiz/view/components/switch__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CreateSoloMatchPage extends BasePage {
  @override
  _CreateSoloMatchPageState createState() => _CreateSoloMatchPageState();
}

class _CreateSoloMatchPageState extends BasePageState<CreateSoloMatchPage>
    with BasicPage, SingleTickerProviderStateMixin {
  Game game;
  double seconds = 30.0;
  bool withHandicap = true;

  @override
  void initState() {
    super.initState();
    this.game =
        Provider.of<CurrentGameProvider>(context, listen: false).getGame();
  }

  @override
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth(),
              padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 8.0),
              child: Text(
                appLocale().create_match__handicap,
                style: appTheme().textTheme.headline,
              ),
            ),
            Container(
              color: Color(0xCCFFFFFF),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(appLocale().create_match__handicap__switch_text,
                      style: appTheme()
                          .textTheme
                          .body2
                          .copyWith(color: appTheme().highlightColor)),
                  SwitchComponent(
                    initValue: withHandicap,
                    onChanged: (isActive) {
                      setState(() {
                        withHandicap = isActive;
                        game.handicap = withHandicap;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight() * 0.05),
            CustomPickerComponent(
              title: appLocale().create_match__question_duration,
              subtitle: appLocale().create_match__question_duration__custom,
              valueList: {
                appLocale().create_match__question_duration__seconds(15): 15.0,
                appLocale().create_match__question_duration__seconds(30): 30.0,
                appLocale().create_match__question_duration__seconds(60): 60.0
              },
              onValueChanged: (value) {
                setState(() {
                  seconds = value + 0.0;
                });
              },
            )
          ],
        ),
        AuthButtonComponent(
          text: Text(appLocale().create_match__start_button,
              style: appTheme().textTheme.button),
          margin: EdgeInsets.symmetric(vertical: 40.0),
          onPressed: () {
            startGame(game);
          },
        ),
      ],
    );
  }

  startGame(Game game) {
    var gameId = Uuid();
    game.questionDuration = seconds;
    game.gameUsers.values.toList()[0].gameProgress = 1;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    game.matchName = "Solo match - $formattedDate";
    game.isActive = true;
    game.id = gameId.v4();
    Provider.of<CurrentGameProvider>(context, listen: false).setGame(game);

    Navigator.pushNamedAndRemoveUntil(context, gameFlowQuestionRoute,
        ModalRoute.withName(Navigator.defaultRouteName));
  }

  @override
  String title() => appLocale().create_match__title__solo_match;
}
