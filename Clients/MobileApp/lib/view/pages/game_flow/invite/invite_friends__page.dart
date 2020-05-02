import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/models/player_status.dart';
import 'package:golfquiz/providers/friend__provider.dart';
import 'package:golfquiz/providers/current_game__provider.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/card_list__component.dart';
import 'package:golfquiz/view/components/card_list_row__component.dart';
import 'package:golfquiz/view/components/card_list_title__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:provider/provider.dart';

import 'invite_helper.dart';

class InviteFriendsPage extends BasePage {
  @override
  _InviteFriendsPageState createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends BasePageState<InviteFriendsPage>
    with BasicPage {
  @override
  Widget body() {
    double cardHeight = screenHeight() - appBarHeight() - 170;
    double listHeight = cardHeight - 15;
    double cardWidth = screenWidth() - 40;

    Game game =
        Provider.of<CurrentGameProvider>(context, listen: false).getGame();
    List<PlayerStatus> gamePlayerStatusList = game.playerStatus;

    bool isMaxPlayersReached = isMaxPlayersInvited(game, gamePlayerStatusList);

    // The visible card
    return CardList(
      cardHeight: cardHeight,
      child: Column(
        children: <Widget>[
          // Title
          CardListTitleComponent(
            rowWidth: cardWidth,
            titleStrings: [
              appLocale().groups__group_list__first_title,
              appLocale().groups__group_list__second_title,
            ],
          ),
          Divider(
            height: 8,
            thickness: 2,
          ),
          Consumer<FriendProvider>(builder: (context, provider, child) {
            Player currentPlayer =
                Provider.of<PlayerProvider>(context).getPlayer;
            List<Player> friendlist = provider.getFriends();

            return Container(
              height: listHeight,
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                ),
                itemCount: friendlist.length + 1,
                itemBuilder: (context, index) {
                  // Add button at the button of the list
                  if (index == friendlist.length &&
                      game.gameType == GameType.two_player_match) {
                    return Container();
                  }

                  final friend = friendlist[index];

                  bool isPlayerInList = isPlayerinGamePlayerStatusList(
                      friend, gamePlayerStatusList);

                  bool isCurrentPlayer = currentPlayer.id == friend.id;

                  bool showAddButton = shouldShowInviteButton(
                      isCurrentPlayer, isMaxPlayersReached, isPlayerInList);

                  return CardListRowComponent(
                    showSelectButton: showAddButton,
                    selectButtonSelected: isPlayerInList,
                    rowStrings: <String>[
                      friend.username,
                      friend.firstName,
                      '${friend.highScore}',
                    ],
                    rowHeight: index == 0 ? 35 : 30,
                    rowWidth: cardWidth,
                    onTap: () => onTapAction(friend),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  void onTapAction(Player friend) {
    setState(() {
      addPlayerToGame(friend, context);
    });
  }

  @override
  String title() => appLocale().friends__title;
}
