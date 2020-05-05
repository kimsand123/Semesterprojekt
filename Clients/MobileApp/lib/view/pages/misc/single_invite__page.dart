import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/invite.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/network/invite_service.dart';
import 'package:golfquiz_dtu/network/remote_helper.dart';
import 'package:golfquiz_dtu/providers/invite_list__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/auth__components/auth_button__component.dart';
import 'package:golfquiz_dtu/view/components/delete_button__component.dart';
import 'package:golfquiz_dtu/view/components/status__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';
import 'package:provider/provider.dart';

class InvitePage extends BasePage {
  final Invite _invite;

  InvitePage({@required Invite invite}) : this._invite = invite;

  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends BasePageState<InvitePage> with BasicPage {
  Invite shownInvite;
  bool asReciever = false;

  @override
  Widget body() {
    if (widget._invite == null) {
      shownInvite = Provider.of<InviteListProvider>(context, listen: false)
          .getInviteList()
          .first;
    } else {
      shownInvite = widget._invite;
    }

    Player player = Provider.of<MeProvider>(context, listen: false).getPlayer;

    if (shownInvite.receiverPlayer.id == player.id) {
      asReciever = true;
    }

    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: screenHeight() * 0.05),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                  asReciever ? "You have been invited" : "You are inviting",
                  style: Theme.of(context).textTheme.headline.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
              alignment: Alignment.centerLeft,
              child: Text("${shownInvite.matchName}",
                  style: Theme.of(context).textTheme.body2.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
            StatusComponent(
              rowStrings: asReciever
                  ? [
                      "Question duration",
                      '${shownInvite.questionDuration}',
                      "Invite from",
                      '${shownInvite.senderPlayer.firstName}',
                      "Accepted?",
                      shownInvite.accepted ? "Yes" : "No",
                    ]
                  : [
                      "Question duration",
                      '${shownInvite.questionDuration}',
                      "Invite to",
                      '${shownInvite.receiverPlayer.firstName}',
                      "Accepted?",
                      shownInvite.accepted ? "Yes" : "No",
                    ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Visibility(
          visible: asReciever && !shownInvite.accepted,
          child: AuthButtonComponent(
            text: Text("Accept"),
            onPressed: () async {
              await enableProgressIndicator("Accepting invite...");
              await InviteService.acceptInvite(shownInvite)
                  .then((receivedData) async {
                await RemoteHelper().fillProviders(context, player);

                await disableProgressIndicator();

                Navigator.pop(context);
                return Future.value(true);
              }).catchError((error) async {
                debugPrint("Accepting invite error" + error.toString());
                await disableProgressIndicator();
              });
            },
          ),
        ),
        Visibility(
          visible: !asReciever,
          child: DeleteButtonComponent(
            buttonText: "Delete",
            onDeleteAction: () async {
              await enableProgressIndicator("Deleting invite...");
              await InviteService.deleteInvite(shownInvite)
                  .then((receivedData) async {
                await RemoteHelper().fillProviders(context, player);

                await disableProgressIndicator();

                Navigator.pop(context);
                return Future.value(true);
              }).catchError((error) async {
                debugPrint("Deleting invite error" + error.toString());
                await disableProgressIndicator();
              });
            },
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }

  @override
  String title() => "Invite";
}
