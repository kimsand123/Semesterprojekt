import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/network/player_service.dart';
import 'package:golfquiz_dtu/network/remote_helper.dart';
import 'package:golfquiz_dtu/providers/friend__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/card_list__component.dart';
import 'package:golfquiz_dtu/view/components/card_list_row__component.dart';
import 'package:golfquiz_dtu/view/components/card_list_title__component.dart';
import 'package:golfquiz_dtu/view/components/popup__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';
import 'package:provider/provider.dart';

class FriendsPage extends BasePage {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends BasePageState<FriendsPage> with BasicPage {
  @override
  Widget body() {
    double cardHeight = screenHeight() - appBarHeight() - 170;
    double listHeight = cardHeight - 120;
    double cardWidth = screenWidth() - 40;

    return Column(
      children: <Widget>[
        // The visible card
        CardList(
          cardHeight: cardHeight,
          child: Column(
            children: <Widget>[
              // Title
              CardListTitleComponent(
                rowWidth: cardWidth,
                titleStrings: [
                  appLocale().friends__list_first_title,
                  "Highscore",
                ],
              ),
              Divider(
                height: 8,
                thickness: 2,
              ),
              Consumer<FriendProvider>(builder: (context, provider, child) {
                List<Player> friendlist = provider.getFriends();

                return Container(
                  height: listHeight,
                  child: RefreshIndicator(
                    onRefresh: _getData,
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1,
                      ),
                      itemCount: friendlist.length,
                      itemBuilder: (context, index) {
                        final friend = friendlist[index];

                        return CardListRowComponent(
                            selectButtonSelected: true,
                            rowStrings: <String>[
                              friend.username + " - " + friend.firstName,
                              '${friend.highScore}',
                            ],
                            rowHeight: index == 0 ? 35 : 30,
                            rowWidth: cardWidth,
                            onTap: () => onTapAction(friend));
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  void onTapAction(Player user) {
    Navigator.pushNamed(context, profileRoute, arguments: user);
  }

  @override
  String title() => appLocale().friends__title;

  Future<void> _getData() async {
    Player currentPlayer =
        Provider.of<MeProvider>(context, listen: false).getPlayer;

    return PlayerService.fetchPlayers(currentPlayer).then((value) async {
      Provider.of<FriendProvider>(context, listen: false).setFriendList(value);

      setState(() {});

      return Future.value(true);
    }).catchError(
      (error) async {
        debugPrint("Fetching players error" + error.toString());
        await disableProgressIndicator();

        if (error == "Token invalid") {
          showPopupDialog(
            context,
            'Your session has expired',
            'The app will log out. \nPlease login again.',
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
        } else {
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
        }
      },
    );
  }
}
