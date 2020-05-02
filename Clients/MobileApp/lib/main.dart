import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:golfquiz/providers/friend__provider.dart';
import 'package:golfquiz/providers/game_list__provider.dart';
import 'package:golfquiz/providers/current_game__provider.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/routing/router.dart';
import 'package:golfquiz/view/themes/light_theme.dart';
import 'package:provider/provider.dart';

import 'localization/appLocalizations.dart';

void main() => runApp(
        //Providers
        MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlayerProvider(),
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
      ],
      child: GolfQuiz(),
    ));

class GolfQuiz extends StatefulWidget {
  GolfQuiz({Key key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _GolfQuizState state = context.findAncestorStateOfType<_GolfQuizState>();
    state.changeLanguage(newLocale);
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
