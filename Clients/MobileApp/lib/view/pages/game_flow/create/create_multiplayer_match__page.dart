import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/invite.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/network/invite_service.dart';
import 'package:golfquiz_dtu/network/player_service.dart';
import 'package:golfquiz_dtu/network/remote_helper.dart';
import 'package:golfquiz_dtu/providers/current_game__provider.dart';
import 'package:golfquiz_dtu/providers/friend__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/auth__components/auth_button__component.dart';
import 'package:golfquiz_dtu/view/components/custom_picker__component.dart';
import 'package:golfquiz_dtu/view/components/popup__component.dart';
import 'package:golfquiz_dtu/view/components/standard_button__component.dart';
import 'package:golfquiz_dtu/view/components/text_field__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz_dtu/view/pages/misc/validation__helper.dart';
import 'package:provider/provider.dart';

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
                maxLength: 15,
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
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 8.0),
              child: Text(
                "Invite player",
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                StandardButtonComponent(
                  text: appLocale().create_match__player_invite__friends,
                  width: screenWidth() - 40,
                  onPressed: () async {
                    Provider.of<CurrentGameProvider>(context, listen: false)
                        .setGame(game);

                    await enableProgressIndicator("Gathering friends...");

                    Player currentPlayer =
                        Provider.of<MeProvider>(context, listen: false)
                            .getPlayer;

                    PlayerService.fetchPlayers(currentPlayer)
                        .then((value) async {
                      Provider.of<FriendProvider>(context, listen: false)
                          .setFriendList(value);

                      Navigator.popAndPushNamed(context, friendsRoute);
                      return Future.value(true);
                    }).catchError((error) async {
                      debugPrint("Fetching players error" + error.toString());
                      await disableProgressIndicator();

                      if (error == "Token invalid") {
                        showPopupDialog(
                          context,
                          'You have been logged out',
                          'Your login has been expired, please login again',
                          {
                            Text(
                              "Ok",
                              style: TextStyle(color: Colors.black),
                            ): () {
                              RemoteHelper().emptyProvider(context).then(
                                (v) {
                                  Navigator.of(context)
                                      .pushNamed(inviteFriends);
                                },
                              );
                            },
                          },
                        );
                      }

                      showPopupDialog(
                        context,
                        'An error occured',
                        'Could not connect to the backend.\n${error.toString()}',
                        {
                          Text(
                            "Ok",
                            style: TextStyle(color: Colors.black),
                          ): null,
                        },
                      );
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        Consumer<CurrentGameProvider>(
          builder: (context, provider, child) {
            Game game = provider.getGame();
            List<PlayerStatus> gamePlayerStatusList = game.playerStatus;
            bool isEnoughUsersAdded = gamePlayerStatusList.length >= 2;

            return AuthButtonComponent(
              text: Text("Invite", style: appTheme().textTheme.button),
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
      invitePlayer();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<void> invitePlayer() async {
    Game providerGame =
        Provider.of<CurrentGameProvider>(context, listen: false).getGame();

    Player currentPlayer =
        Provider.of<MeProvider>(context, listen: false).getPlayer;

    Player receiver;

    for (PlayerStatus status in providerGame.playerStatus) {
      if (status.gamePlayer.player.id != currentPlayer.id) {
        receiver = status.gamePlayer.player;
      }
    }

    Invite inviteToPost = Invite(
        senderPlayer: currentPlayer,
        receiverPlayer: receiver,
        matchName: _nameController.text,
        questionDuration: questionDuration,
        accepted: false);

    await enableProgressIndicator("Inviting player...");
    await InviteService.createInvite(inviteToPost).then((value) async {
      await RemoteHelper().fillProviders(context, currentPlayer);

      await disableProgressIndicator();

      Navigator.pop(context);
      return Future.value(true);
    }).catchError((error) async {
      debugPrint("Inviting players error" + error.toString());
      await disableProgressIndicator();

      if (error == "Token invalid") {
        showPopupDialog(
          context,
          'You have been logged out',
          'Your login has been expired, please login again',
          {
            Text(
              "Ok",
              style: TextStyle(color: Colors.black),
            ): () {
              RemoteHelper().emptyProvider(context).then(
                (v) {
                  Navigator.pushNamedAndRemoveUntil(context, introRoute,
                      ModalRoute.withName(Navigator.defaultRouteName));
                },
              );
            },
          },
        );
      }

      showPopupDialog(
        context,
        'An error occured',
        'Could not connect to the backend.\n${error.toString()}',
        {
          Text(
            "Ok",
            style: TextStyle(color: Colors.black),
          ): null,
        },
      );
    });
  }

  @override
  String title() => appLocale().create_match__title__two_player_match;
}
