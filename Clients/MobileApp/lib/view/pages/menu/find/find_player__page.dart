import 'package:flutter/material.dart';
import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/user.dart';
import 'package:golfquiz/providers/friend__provider.dart';
import 'package:golfquiz/providers/global_player__provider.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/card_list__component.dart';
import 'package:golfquiz/view/components/card_list_row__component.dart';
import 'package:golfquiz/view/components/card_list_title__component.dart';
import 'package:golfquiz/view/components/popup__component.dart';
import 'package:golfquiz/view/components/text_field__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz/view/pages/misc/validation__helper.dart';
import 'package:provider/provider.dart';

class FindPlayerPage extends BasePage {
  final PlayerRelationship relationship;

  FindPlayerPage({PlayerRelationship relationship})
      : this.relationship = relationship ?? PlayerRelationship.friend;

  @override
  _FindPlayerPageState createState() => _FindPlayerPageState();
}

class _FindPlayerPageState extends BasePageState<FindPlayerPage>
    with BasicPage {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _findPlayerController;
  bool editMode;
  bool _autoValidate;
  FocusNode _findPlayerFocus;

  @override
  void initState() {
    super.initState();
    _findPlayerController = TextEditingController();
    _findPlayerFocus = FocusNode();
    _autoValidate = false;
  }

  @override
  void dispose() {
    super.dispose();
    _findPlayerController.dispose();
  }

  @override
  Widget body() {
    double cardWidth = screenWidth() - 40;
    double cardHeight = screenHeight() - appBarHeight() - 300;
    double listHeight = cardHeight - 15;

    if (_findPlayerController.text.isEmpty) {
      Provider.of<GlobalPlayerProvider>(context, listen: false)
          .resetGlobalPlayers();
    }

    return Column(
      children: <Widget>[
        Form(
          autovalidate: this._autoValidate,
          key: this._formKey,
          child: TextFieldComponent(
            controller: _findPlayerController,
            caption: appLocale().find_player__search_player,
            hintText: appLocale().find_player__search_player_hint,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            inputType: TextInputType.text,
            isInputHidden: false,
            maxLength: 20,
            fieldValidator: (arg) {
              return ValidationHelper.validateSearchName(arg, context);
            },
            focusNode: _findPlayerFocus,
            onFieldSubmitted: (searchText) {
              _validateAndSaveInputs(searchText);
            },
          ),
        ),
        Stack(
          children: <Widget>[
            CardList(
              cardHeight: cardHeight,
              child: Column(
                children: <Widget>[
                  // Title
                  CardListTitleComponent(
                    rowWidth: cardWidth,
                    titleStrings: [appLocale().player],
                  ),
                  Divider(
                    height: 8,
                    thickness: 2,
                  ),
                  Consumer<GlobalPlayerProvider>(
                    builder: (context, provider, child) {
                      List<User> userList = provider.getSearchedGlobalPlayers;

                      return Container(
                        height: listHeight - 105,
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              Divider(thickness: 1),
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            final userFromList = userList[index];

                            bool isInList =
                                isFoundUserAlreadyInList(userFromList);

                            return CardListRowComponent(
                              showSelectButton: !isInList,
                              selectButtonSelected: false,
                              rowStrings: <String>[
                                userFromList.username,
                                userFromList.firstName,
                                '${userFromList.highScore}',
                              ],
                              rowHeight: index == 0 ? 35 : 30,
                              rowWidth: cardWidth,
                              onTap: () => isInList
                                  ? null
                                  : doYouWantToAdd(userFromList),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  String title() {
    return appLocale().find_player__title;
  }

  _validateAndSaveInputs(String searchString) async {
    if (_formKey.currentState.validate()) {
      findPlayer(searchString);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void doYouWantToAdd(User selectedUser) {
    String descriptionAddText = '';

    if (widget.relationship == PlayerRelationship.friend) {
      descriptionAddText = appLocale().find_player__add_popup__to_friends;
    } else if (widget.relationship == PlayerRelationship.group) {
      descriptionAddText = appLocale().find_player__add_popup__to_group;
    } else {
      descriptionAddText = appLocale().find_player__add_popup__to_club;
    }

    showPopupDialog(
      context,
      appLocale().find_player__add_popup__title(selectedUser.username),
      appLocale().find_player__add_popup__description(
          selectedUser.firstName, descriptionAddText),
      {
        Text(
          appLocale().yes,
          style: appTheme().textTheme.button.copyWith(color: Colors.black),
        ): () {
          setState(() {
            addNewPlayer(selectedUser);
          });
        },
        Text(
          appLocale().no,
          style: appTheme().textTheme.button.copyWith(color: Colors.red[800]),
        ): null,
      },
    );
  }

  Future<void> findPlayer(String searchString) async {
    setState(() {
      enableProgressIndicator(appLocale().find_player__load_players);
    });

    await Provider.of<GlobalPlayerProvider>(context, listen: false)
        .searchInList(searchString);

    setState(() {
      disableProgressIndicator();
    });
  }

  bool isFoundUserAlreadyInList(User foundUser) {
    PlayerRelationship relationship = widget.relationship;

    if (relationship == PlayerRelationship.friend) {
      bool isAFriend = Provider.of<FriendProvider>(context, listen: false)
          .isUserAFriend(foundUser);
      return isAFriend;
    }
  }

  void addNewPlayer(User foundUser) {
    switch (widget.relationship) {
      // Friend case
      case PlayerRelationship.friend:
        Provider.of<FriendProvider>(context, listen: false)
            .addFriend(foundUser);
        break;

      // Default case
      default:
        debugPrint(
            'ERROR: find_player__page.dart - Default case ran with PlayerRelationship ${widget.relationship}');
        break;
    }
  }
}
