import 'package:flutter/material.dart';

class InviteCardComponent extends StatelessWidget {
  final String title;
  final String subTitle;
  final int highscorePlace;
  final onPressed;

  InviteCardComponent(
      {String title,
      String subTitle,
      int highscorePlace,
      VoidCallback onPressed})
      : this.title = title ?? '',
        this.subTitle = subTitle,
        this.highscorePlace = highscorePlace,
        this.onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0x90FFFFFF),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Color(0xFF0000000))),
                Visibility(
                  visible: subTitle != null,
                  child: Text(subTitle ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Color(0xFF0404040))),
                )
              ],
            ),
            highscoreWidget(context, highscorePlace),
          ],
        ),
      ),
    );
  }

  Widget highscoreWidget(BuildContext context, int place) {
    if (place == null) {
      return Container();
    }

    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 5),
          alignment: Alignment.topCenter,
          height: 25,
          width: 20,
          child: Image(
            height: 20,
            image: AssetImage('assets/icons/highscore.png'),
          ),
        ),
        Text(
          "$place",
          style: Theme.of(context).textTheme.body2.copyWith(
                color: Color(0xFF0000000),
              ),
        ),
      ],
    );
  }
}
