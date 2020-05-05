import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:golfquiz_dtu/network/service_constants.dart';
import 'package:golfquiz_dtu/providers/friend__provider.dart';
import 'package:golfquiz_dtu/providers/game_list__provider.dart';
import 'package:golfquiz_dtu/providers/current_game__provider.dart';
import 'package:golfquiz_dtu/providers/invite_list__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/routing/router.dart';
import 'package:golfquiz_dtu/view/themes/light_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization/appLocalizations.dart';

void main() => runApp(
        //Providers
        MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentGameProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FriendProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GameListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InviteListProvider(),
        ),
      ],
      child: GolfQuiz(),
    ));

class GolfQuiz extends StatefulWidget {
  GolfQuiz({Key key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _GolfQuizState state = context.findAncestorStateOfType<_GolfQuizState>();
    state.changeLanguage(newLocale);
  }

  Future<String> initialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String game_service_ip = prefs.get("game_service_ip");
    String game_service_port = prefs.get("game_service_port");

    if (game_service_ip != null && game_service_port != null) {
      ServiceConstants.baseGameUrl = game_service_ip + ":" + game_service_port;
    }

    if (token != null) {
      return gameRoute;
    } else {
      return introRoute;
    }
  }

  @override
  _GolfQuizState createState() => _GolfQuizState();
}

class _GolfQuizState extends State<GolfQuiz> {
  Locale _locale;

  ///
  /// Testing route, made to override the introRoute
  ///
  String testingRoute = null;

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Removed when tablet-mode is introduced
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    String initialRoute;

    //TODO: (GQ-91) - Toggle if user is logged in
    if (true) {
      initialRoute = testingRoute ?? introRoute;
    }

    return MaterialApp(
      theme: LightTheme.themeData,
      onGenerateRoute: Router.generateRoute,
      initialRoute: initialRoute,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale.fromSubtags(languageCode: 'da'),
        const Locale.fromSubtags(languageCode: 'en'),
      ],
      locale: _locale,
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          return null;
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            debugPrint(
                'Supported locale found (${supportedLocale.toString()}), for phonelocale: ${locale.toString()}');
            return supportedLocale;
          }
        }
        debugPrint('No supported locale found, using ${locale.toString()}');
        return supportedLocales.first;
      },
    );
  }
}
