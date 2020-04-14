import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog standardDialog(BuildContext context, String message) {
  var progressdialog = ProgressDialog(context);

  progressdialog.style(
      borderRadius: 15.0,
      message: message,
      backgroundColor: Colors.white,
      progressWidget: Center(
          child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).disabledColor,
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).highlightColor),
      )),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: Theme.of(context)
          .textTheme
          .body1
          .copyWith(color: Theme.of(context).colorScheme.onBackground));

  return progressdialog;
}
