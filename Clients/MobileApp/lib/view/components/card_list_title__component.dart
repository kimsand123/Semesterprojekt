import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardListTitleComponent extends StatelessWidget {
  final List<String> _titleStrings;

  CardListTitleComponent({
    @required List<String> titleStrings,
    @required double rowWidth,
    bool showSelectButton,
  }) : this._titleStrings = titleStrings ?? [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: createListOfTitles(context)),
    );
  }

  List<Widget> createListOfTitles(BuildContext context) {
    int length = _titleStrings.length;
    double singleTitleWidth = (MediaQuery.of(context).size.width / length) - 2;

    List<Widget> rowWidgets = [];

    _titleStrings.forEach((title) {
      rowWidgets.add(
          this._createSingleTitle(title, singleTitleWidth / length, context));
    });

    return rowWidgets;
  }

  Widget _createSingleTitle(String title, double width, BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.fade,
        style: Theme.of(context)
            .textTheme
            .headline
            .copyWith(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
