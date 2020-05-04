import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/localization/appLocalizations.dart';

class ProgressbarComponent extends StatelessWidget {
  final int step;
  ProgressbarComponent({this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      width: MediaQuery.of(context).size.width,
      height: 65.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: .5),
          color: Color(0x70FFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(AppLocalization.of(context).progressbar_text,
              style: Theme.of(context).textTheme.body2),
          makeStepBubbles(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: makeProgressList(context, step),
          )
        ],
      ),
    );
  }
}

Widget makeStepBubbles(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text('0', style: Theme.of(context).textTheme.body2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: .5)),
          width: 25.0,
          height: 25.0,
        ),
        Container(
          child: Text('9', style: Theme.of(context).textTheme.body2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: .5)),
          width: 25.0,
          height: 25.0,
        ),
        Container(
          child: Text('18', style: Theme.of(context).textTheme.body2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: .5)),
          width: 25.0,
          height: 25.0,
        ),
      ],
    ),
  );
}

List<Widget> makeProgressList(BuildContext context, int step) {
  List<Widget> progressList = List();
  Color color;

  for (var i = 0; i < 18; i++) {
    if (i < step) {
      color = Theme.of(context).highlightColor;
    } else {
      color = Colors.white;
    }
    progressList.add(Container(
      margin: EdgeInsets.only(left: 1.0, right: 1.0, bottom: 8.0),
      width: MediaQuery.of(context).size.width * 0.044,
      height: 10.0,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Theme.of(context).highlightColor)),
    ));
  }
  return progressList;
}
