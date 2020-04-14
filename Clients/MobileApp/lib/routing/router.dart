import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/tournament.dart';
import 'package:golfquiz/models/user.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/pages/auth/forgot_password__page.dart';
import 'package:golfquiz/view/pages/auth/intro__page.dart';
import 'package:golfquiz/view/pages/auth/login__page.dart';
import 'package:golfquiz/view/pages/auth/signup__page.dart';
import 'package:golfquiz/view/pages/bottom_navigation/navigation__container.dart';
import 'package:golfquiz/view/pages/game_flow/create/create_multiplayer_match__page.dart';
import 'package:golfquiz/view/pages/game_flow/create/create_solo_match__page.dart';
import 'package:golfquiz/view/pages/game_flow/game/game_flow_question__page.dart';
import 'package:golfquiz/view/pages/game_flow/game/game_flow_result__page.dart';
import 'package:golfquiz/view/pages/game_flow/game/game_flow_scoreboard__page.dart';
import 'package:golfquiz/view/pages/game_flow/invite/invite_friends__page.dart';
import 'package:golfquiz/view/pages/menu/find/find_player__page.dart';
import 'package:golfquiz/view/pages/menu/friends/friends__page.dart';
import 'package:golfquiz/view/pages/menu/profile/edit_profile__page.dart';
import 'package:golfquiz/view/pages/menu/profile/profile__page.dart';
import 'package:golfquiz/view/pages/misc/privacy_policy__page.dart';
import 'package:golfquiz/view/pages/misc/terms_and_conditions__page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
      case introRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: introRoute),
            builder: (_) => IntroPage());

      case signupRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: signupRoute),
            builder: (_) => SignupPage());

      case loginRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: loginRoute),
            builder: (_) => LoginPage());

      case forgotPasswordRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(
            settings: RouteSettings(name: loginRoute),
            builder: (_) => ForgotPasswordPage(enteredEmail: data));

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
        var data = settings.arguments as User;
        return MaterialPageRoute(
            settings: RouteSettings(name: profileRoute),
            builder: (_) => ProfilePage(
                  user: data,
                ));

      case editProfileRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: editProfileRoute),
            builder: (_) => EditProfilePage());

      case friendsRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: friendsRoute),
            builder: (_) => FriendsPage());

      case soloCreateRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: soloCreateRoute),
            builder: (_) => CreateSoloMatchPage());

      case twoPlayerCreateRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: twoPlayerCreateRoute),
            builder: (_) => CreateMultiplayerMatchPage());

      case findPlayerRoute:
        PlayerRelationship data = settings.arguments;
        return MaterialPageRoute(
            settings: RouteSettings(name: findPlayerRoute),
            builder: (_) => FindPlayerPage(
                  relationship: data,
                ));

      // Terms and privacy
      case termsRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: termsRoute),
            builder: (_) => TermsAndConditionsPage());

      case privacyPolicyRoute:
        return MaterialPageRoute(
            settings: RouteSettings(name: privacyPolicyRoute),
            builder: (_) => PrivacyPolicyPage());

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
            settings: RouteSettings(name: gameFlowAnswerRoute),
            builder: (_) => GameFlowScoreboardPage());

      // Invite
      case inviteFriends:
        return MaterialPageRoute(
          settings: RouteSettings(name: inviteFriends),
          builder: (_) => InviteFriendsPage(),
        );

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
