import 'package:flutter/material.dart';

class StatusComponent extends StatelessWidget {
  final List<String> _rowStrings;

  StatusComponent({
    List<String> rowStrings,
  }) : this._rowStrings = rowStrings ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: listOfRows(_rowStrings, context),
    );
  }

  List<Widget> listOfRows(List<String> listOfStrings, BuildContext context) {
    int rest = listOfStrings.length % 2;
    int lengthUsed = listOfStrings.length - rest;
    List<Widget> rowList = [];

    for (int i = 0; i < lengthUsed; i++) {
      String title = listOfStrings[i];
      String value = listOfStrings[i + 1];

      rowList.add(createRow(title, value, context));

      i++;
    }

    return rowList;
  }

  Widget createRow(String title, String value, BuildContext context) {
    return Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 30,
            width: MediaQuery.of(context).size.width * 0.5 - 20,
            decoration: BoxDecoration(
                color: Color(0xFFF8FFF8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0))),
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Color(0xFF000000))),
          ),
          Container(
            alignment: Alignment.center,
            height: 30,
            width: MediaQuery.of(context).size.width * 0.5 - 20,
            decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0))),
            child: Text(value,
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Color(0xFF000000))),
          ),
        ],
      ),
    );
  }
}
