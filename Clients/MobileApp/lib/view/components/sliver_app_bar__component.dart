import 'package:flutter/material.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/view/components/progressbar__component.dart';

class SliverAppBarComponent extends StatelessWidget {
  final Game game;
  final _fontSize;
  final _rowLeftContent, _rowRightContent, currentUserInfo;
  final Widget middleWidget;
  final String _title, _rowLeftTitle, _rowRightTitle;
  final bool showProgress;

  SliverAppBarComponent(
      {this.game,
      fontSize,
      rowLeftContent,
      rowRightContent,
      rowLeftTitle,
      rowRightTitle,
      this.currentUserInfo,
      this.middleWidget,
      title,
      this.showProgress}):
      this._fontSize = fontSize ?? 18.0,
      this._rowLeftContent = rowLeftContent ?? '',
      this._rowRightContent = rowRightContent ?? '',
      this._rowLeftTitle = rowLeftTitle ?? '',
      this._rowRightTitle = rowRightTitle ?? '',
      this._title = title ?? '';

  @override
  Widget build(BuildContext context) {
    Widget progressbar = showProgress
        ? ProgressbarComponent(step: currentUserInfo.gameProgress)
        : Container();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(_title, style: Theme.of(context).textTheme.subhead.copyWith(fontSize: _fontSize)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
