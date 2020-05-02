import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/providers/friend__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/card_list__component.dart';
import 'package:golfquiz/view/components/card_list_row__component.dart';
import 'package:golfquiz/view/components/card_list_title__component.dart';
import 'package:golfquiz/view/components/notification_button__component.dart';
import 'package:golfquiz/view/components/popup__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:provider/provider.dart';

class FriendsPage extends BasePage {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends BasePageState<FriendsPage> with BasicPage {
  bool notificationShown = false;
  bool editMode = false;

  @override
  Widget action() {
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: IconButton(
        icon: Icon(editMode ? Icons.check : Icons.edit),
        onPressed: () {
          // Change editMode
          setState(() {
            editMode = !editMode;
          });
        },
      ),
    );
  }

  @override
  Widget body() {
    double cardHeight = screenHeight() - appBarHeight() - 170;
    double listHeight = cardHeight - 120;
    double cardWidth = screenWidth() - 40;

    return Column(
      children: <Widget>[
        //Notification bar
        Container(
            child: Container(
          child: Visibility(
            visible: notificationShown,
            child: NotificationButton(
              title: appLocale().friends__notification,
            ),
          ),
        )),

        // The visible card
        CardList(
          cardHeight: cardHeight,
          child: Column(
            children: <Widget>[
              // Add button
              GestureDetector(
                child: ListTile(
                  title: Text(
                    appLocale().friends__add_friends_button,
                    style: appTheme().textTheme.subhead.copyWith(
                        color: appTheme().secondaryHeaderColor,
                        fontWeight: FontWeight.w800),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, findPlayerRoute,
                        arguments: PlayerRelationship.friend);
                  },
                ),
              ),

              // Title
              CardListTitleComponent(
                rowWidth: cardWidth,
                titleStrings: [
                  appLocale().friends__list_first_title,
                  appLocale().friends__list_second_title,
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
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1,
                    ),
                    itemCount: friendlist.length,
                    itemBuilder: (context, index) {
                      final friend = friendlist[index];

                      return CardListRowComponent(
                        showSelectButton: editMode,
                        selectButtonSelected: true,
                        rowStrings: <String>[
                          friend.username,
                          friend.firstName,
                          '${friend.highScore}',
                        ],
                        rowHeight: index == 0 ? 35 : 30,
                        rowWidth: cardWidth,
                        onTap: editMode
                            ? () => deleteTapAction(friend)
                            : () => onTapAction(friend),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  void deleteTapAction(Player user) {
    showPopupDialog(
      context,
      appLocale().dialog__are_you_sure,
      appLocale().dialog__delete(user.firstName + user.lastName),
      {
        Text(
          appLocale().yes,
          style: appTheme().textTheme.button.copyWith(color: Colors.black),
        ): () {
          setState(() {
            Provider.of<FriendProvider>(context, listen: false)
                .removeFriend(user);
            this.editMode = false;
          });
        },
        Text(
          appLocale().no,
          style: appTheme().textTheme.button.copyWith(color: Colors.red[800]),
        ): null,
      },
    );
  }

  void onTapAction(Player user) {
    Navigator.pushNamed(context, profileRoute, arguments: user);
  }

  @override
  String title() => appLocale().friends__title;
}
