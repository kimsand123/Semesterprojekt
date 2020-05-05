import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/invite.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/providers/invite_list__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/invite_card__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz_dtu/view/pages/misc/invite_list__helper.dart';
import 'package:provider/provider.dart';

import '../../../routing/route_constants.dart';

class InviteListPage extends BasePage {
  @override
  _InviteListPageState createState() => _InviteListPageState();
}

class _InviteListPageState extends BasePageState<InviteListPage>
    with BasicPage {
  @override
  String title() => "Invites";

  @override
  Widget body() {
    return Container(
      child: Consumer<InviteListProvider>(
        builder: (context, provider, child) {
          Player currentPlayer =
              Provider.of<MeProvider>(context, listen: false).getPlayer;

          // Gather the list of invites
          List<Invite> listOfInvites = provider.getInviteList();

          // Sort by if you are the receiver
          listOfInvites.sort((a, b) {
            return sortInvitesListAfterReceiver(a, b, currentPlayer);
          });

          // Get number of receiver invites for seperation
          int numberOfReceiverInvites =
              gatherAcceptedInvites(listOfInvites, currentPlayer).length;

          return Container(
            height: contentHeight,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: listOfInvites.length,
              itemBuilder: (BuildContext context, int index) {
                var inviteItem = listOfInvites[index];

                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("To you"),
                      ),
                      SizedBox(height: 4),
                      itemGenerator(inviteItem),
                    ],
                  );
                } else if (index == numberOfReceiverInvites) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("From you"),
                      ),
                      SizedBox(height: 4),
                      itemGenerator(inviteItem),
                    ],
                  );
                } else {
                  return itemGenerator(inviteItem);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget itemGenerator(Invite inviteItem) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: InviteCardComponent(
        title: inviteItem.matchName,
        subTitle: generateSubtitle(inviteItem),
        highscorePlace: null,
        onPressed: () {
          Navigator.pushNamed(context, singleInviteRoute,
              arguments: inviteItem);
        },
      ),
    );
  }

  String generateSubtitle(Invite invite) {
    if (invite.accepted) {
      return "Accepted";
    } else {
      return "Not accepted";
    }
  }
}
