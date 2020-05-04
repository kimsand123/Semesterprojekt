import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/invite.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/pages/auth/intro__page.dart';
import 'package:golfquiz_dtu/view/pages/auth/login__page.dart';
import 'package:golfquiz_dtu/view/pages/bottom_navigation/navigation__container.dart';
import 'package:golfquiz_dtu/view/pages/game_flow/create/create_multiplayer_match__page.dart';
import 'package:golfquiz_dtu/view/pages/game_flow/game/game_flow_question__page.dart';
import 'package:golfquiz_dtu/view/pages/game_flow/game/game_flow_result__page.dart';
import 'package:golfquiz_dtu/view/pages/game_flow/game/game_flow_scoreboard__page.dart';
import 'package:golfquiz_dtu/view/pages/game_flow/invite/invite_friends__page.dart';
import 'package:golfquiz_dtu/view/pages/menu/friends/friends__page.dart';
import 'package:golfquiz_dtu/view/pages/menu/profile/profile__page.dart';
import 'package:golfquiz_dtu/view/pages/misc/game_list__page.dart';
import 'package:golfquiz_dtu/view/pages/misc/invite_list__page.dart';
import 'package:golfquiz_dtu/view/pages/misc/single_game__page.dart';
import 'package:golfquiz_dtu/view/pages/misc/single_invite__page.dart';

import 'route_constants.dart';
import 'route_constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
      case introRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: introRoute),
            builder: (_) => IntroPage());

      case loginRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: loginRoute),
            builder: (_) => LoginPage());

      // Tabbar navigation
      case gameRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: gameRoute),
            builder: (_) => BottomNavigationContainer(
                  initPage: 0,
                ));

      case menuRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: menuRoute),
            builder: (_) => BottomNavigationContainer(
                  initPage: 1,
                ));

      case profileRoute:
        var data = settings.arguments as Player;
        return MaterialPageRoute(
            settings: RouteSettings(name: profileRoute),
            builder: (_) => ProfilePage(
                  user: data,
                ));

      case friendsRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: friendsRoute),
            builder: (_) => FriendsPage());

      case twoPlayerCreateRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: twoPlayerCreateRoute),
            builder: (_) => CreateMultiplayerMatchPage());

      // Game
      case gameFlowQuestionRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: gameFlowQuestionRoute),
            builder: (_) => GameFlowQuestionPage());

      case gameFlowAnswerRoute:
        var data = settings.arguments as bool;
        return MaterialPageRoute(
            settings: RouteSettings(name: gameFlowAnswerRoute),
            builder: (_) => GameFlowResultPage(wasQuestionCorrect: data));

      case gameFlowScoreboard:
        return MaterialPageRoute(
            settings: RouteSettings(name: gameFlowScoreboard),
            builder: (_) => GameFlowScoreboardPage());

      case singleGameRoute:
        Game game = settings.arguments;
        return MaterialPageRoute(
            settings: RouteSettings(name: singleGameRoute),
            builder: (_) => SingleGamePage(
                  gameItem: game,
                ));

      // Misc
      case gameListRoute:
        GameType gameType = settings.arguments;
        return MaterialPageRoute(
          settings: RouteSettings(name: gameListRoute),
          builder: (_) => GameListPage(
            gameListType: gameType,
          ),
        );

      case inviteListRoute:
        return MaterialPageRoute(
          settings: RouteSettings(name: inviteListRoute),
          builder: (_) => InviteListPage(),
        );

      // Invite
      case inviteFriends:
        return MaterialPageRoute(
          settings: RouteSettings(name: inviteFriends),
          builder: (_) => InviteFriendsPage(),
        );

      case singleInviteRoute:
        var data = settings.arguments as Invite;
        return MaterialPageRoute(
            settings: RouteSettings(name: singleInviteRoute),
            builder: (_) => InvitePage(invite: data));

      // Default (404)
      default:
        return MaterialPageRoute(
            settings: RouteSettings(name: 'Error/${settings.name}'),
            builder: (_) {
              return Scaffold(
                // Cannot be localized because of missing context
                appBar: AppBar(title: Text(settings.name)),
                body: Center(
                    child: Text(
                        'The page \'${settings.name}\' \nIs not implemented yet.')),
              );
            });
    }
  }
}
