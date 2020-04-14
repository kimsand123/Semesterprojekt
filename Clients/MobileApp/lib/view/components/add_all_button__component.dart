import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfquiz/localization/appLocalizations.dart';

class AddAllButtonComponent extends StatelessWidget {
  final VoidCallback _onTab;

  AddAllButtonComponent({VoidCallback onTab}) : this._onTab = onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTab,
      child: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(top: 10),
        child: Text(
          AppLocalization.of(context).add_all_button_text,
          style: Theme.of(context).textTheme.body1.copyWith(
              color: Theme.of(context).secondaryHeaderColor,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
