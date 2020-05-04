import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/view/components/progressbar__component.dart';

class SliverAppBarComponent extends StatelessWidget {
  final Game game;
  final _fontSize;
  final String _rowLeftContent, _rowRightContent;
  final PlayerStatus currentUserInfo;
  final Widget middleWidget;
  final String _title, _rowLeftTitle, _rowRightTitle;
  final bool showProgress;

  SliverAppBarComponent(
      {@required Game game,
      double fontSize,
      String rowLeftContent,
      String rowRightContent,
      String rowLeftTitle,
      String rowRightTitle,
      @required PlayerStatus currentPlayerStatus,
      Widget middleWidget,
      String title,
      bool showProgress})
      : this.game = game,
        this._fontSize = fontSize ?? 18.0,
        this._rowLeftContent = rowLeftContent ?? '',
        this._rowRightContent = rowRightContent ?? '',
        this._rowLeftTitle = rowLeftTitle ?? '',
        this._rowRightTitle = rowRightTitle ?? '',
        this.currentUserInfo = currentPlayerStatus,
        this.middleWidget = middleWidget,
        this._title = title ?? '',
        this.showProgress = showProgress ?? false;

  @override
  Widget build(BuildContext context) {
    Widget progressbar = showProgress
        ? ProgressbarComponent(step: currentUserInfo.gamePlayer.gameProgress)
        : Container();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(_title,
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(fontSize: _fontSize)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_rowLeftTitle,
                        style: Theme.of(context).textTheme.body2),
                    Text('${this._rowLeftContent}',
                        style: Theme.of(context).textTheme.body2)
                  ],
                ),
                this.middleWidget,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(_rowRightTitle,
                        style: Theme.of(context).textTheme.body2),
                    Text('${this._rowRightContent}',
                        style: Theme.of(context).textTheme.body2)
                  ],
                )
              ],
            ),
          ),
          progressbar
        ],
      ),
    );
  }
}
