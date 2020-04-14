import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/view/components/card_list_add_component.dart';

class CardListRowComponent extends StatelessWidget {
  final List<String> _rowStrings;
  final double _rowHeight;
  final double _rowWidth;
  final bool _showSelectButton;
  final bool _selectButtonSelected;
  final VoidCallback _onTap;

  CardListRowComponent(
      {@required List<String> rowStrings,
      @required double rowHeight,
      @required double rowWidth,
      bool showSelectButton,
      bool selectButtonSelected,
      VoidCallback onTap})
      : this._rowStrings = rowStrings ?? [],
        this._rowHeight = rowHeight ?? 30,
        this._rowWidth = rowWidth ?? 300,
        this._showSelectButton = showSelectButton ?? false,
        this._selectButtonSelected = selectButtonSelected ?? false,
        this._onTap = onTap;

  @override
  Widget build(BuildContext context) {
    double innerRowWidth = _rowWidth - (this._showSelectButton ? 65 : 45);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: _rowHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Visibility(
                  visible: _showSelectButton,
                  child: CardListAddButtonComponent(
                    selected: _selectButtonSelected,
                  ),
                ),
                Container(
                  width: innerRowWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: createRowOfTexts(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> createRowOfTexts(BuildContext context) {
    int length = _rowStrings.length;
    double singleTitleWidth = (_rowWidth / length) - 2;

    List<Widget> rowWidgets = [];

    _rowStrings.forEach((text) {
      rowWidgets.add(this._createSingleText(text, singleTitleWidth, context));
    });

    return rowWidgets;
  }

  Widget _createSingleText(String text, double width, BuildContext context) {
    return Container(
      child: Text(
        text,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.body1.copyWith(color: Colors.black),
      ),
    );
  }
}
