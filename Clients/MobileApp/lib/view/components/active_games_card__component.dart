import 'package:flutter/material.dart';
import 'package:golfquiz/localization/appLocalizations.dart';

class ActiveGamesCardComponent extends StatelessWidget {
  final String gameMode;
  final Widget gameModeIcon;
  final onPressed;

  ActiveGamesCardComponent({this.gameMode, this.gameModeIcon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        height: 80,
        width: MediaQuery.of(context).size.width - 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0x90FFFFFF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(gameMode,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Color(0xFF0000000))),
            SizedBox(height: 16.0),
            Text(
                AppLocalization.of(context).active_games_card__show_all_matches,
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Color(0x80000000)))
          ],
        ),
      ),
    );
  }
}
