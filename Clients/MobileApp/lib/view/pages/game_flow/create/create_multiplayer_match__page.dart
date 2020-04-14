import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/providers/current_game__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/auth__components/auth_button__component.dart';
import 'package:golfquiz/view/components/custom_picker__component.dart';
import 'package:golfquiz/view/components/standard_button__component.dart';
import 'package:golfquiz/view/components/text_field__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz/view/pages/misc/validation__helper.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateMultiplayerMatchPage extends BasePage {
  @override
  _CreateMultiplayerMatchPageState createState() =>
      _CreateMultiplayerMatchPageState();
}

class _CreateMultiplayerMatchPageState
    extends BasePageState<CreateMultiplayerMatchPage>
    with BasicPage, SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Game game;
  TextEditingController _nameController;
  bool _autoValidate;
  FocusNode _nameFocus;
  double questionDuration = 30.0;
  int gamePlayerResponseTime = 3;
  int gameRounds = 1;
  String responseTime;
  bool withHandicap = true;

  @override
  void initState() {
    super.initState();
    _autoValidate = false;
    _nameController = TextEditingController();
    _nameFocus = FocusNode();
    responseTime = '1';

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
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 0.0),
              child: Text(
                appLocale().create_match__match_name,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: TextFieldComponent(
                controller: _nameController,
                hintText: appLocale().create_match__match_name__hint_text,
                inputType: TextInputType.text,
                maxLength: 10,
                isInputHidden: false,
                focusNode: _nameFocus,
                textInputAction: TextInputAction.done,
                fieldValidator: (arg) {
                  return ValidationHelper.validateMatchName(arg, context);
                },
                onFieldSubmitted: (term) {
                  setState(() {
                    _nameFocus.unfocus();
                    _autoValidate = true;
                  });
                },
                caption: '',
                margin: EdgeInsets.symmetric(horizontal: 20.0),
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
                  questionDuration = value + 0.0;
                });
              },
            ),
            SizedBox(height: screenHeight() * 0.05),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 8.0),
              child: Text(
                appLocale().create_match__player_invite,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                StandardButtonComponent(
                  text: appLocale().create_match__player_invite__friends,
                  width: screenWidth() - 40,
                  onPressed: () {
                    Provider.of<CurrentGameProvider>(context, listen: false)
                        .setGame(game);
                    Navigator.of(context).pushNamed(inviteFriends);
                  },
                ),
              ],
            ),
          ],
        ),
        Consumer<CurrentGameProvider>(
          builder: (context, provider, child) {
            Game game = provider.getGame();
            Map gameUsersMap = game.gameUsers ?? {};
            bool isEnoughUsersAdded = gameUsersMap.length >= 2;

            return AuthButtonComponent(
              text: Text(appLocale().create_match__start_button,
                  style: appTheme().textTheme.button),
              margin: EdgeInsets.symmetric(vertical: 40.0),
              onPressed:
                  isEnoughUsersAdded ? () => _validateAndSaveInputs() : null,
            );
          },
        ),
      ],
    );
  }

  _validateAndSaveInputs() async {
    if (_formKey.currentState.validate()) {
      startGame();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void startGame() {
    var gameId = Uuid();
    Game providerGame =
        Provider.of<CurrentGameProvider>(context, listen: false).getGame();
    providerGame.playerResponseTime = gamePlayerResponseTime;
    providerGame.rounds = gameRounds;
    providerGame.questionDuration = questionDuration;
    providerGame.matchName = _nameController.text;
    providerGame.handicap = true;
    providerGame.isActive = true;
    providerGame.isItFirstPlayer = true;
    providerGame.id = gameId.v4();
    Provider.of<CurrentGameProvider>(context, listen: false).setGame(game);

    Navigator.pushNamedAndRemoveUntil(context, gameFlowQuestionRoute,
        ModalRoute.withName(Navigator.defaultRouteName));
  }

  @override
  String title() => appLocale().create_match__title__two_player_match;
}
