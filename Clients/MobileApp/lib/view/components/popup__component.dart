// user defined function
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

///  Example Method:
///
///    **showPopupDialog**(
///      context,
///      "Hello",
///      "Describing text",
///      {
///        Text(
///        "Hello 1",
///        style: appTheme()
///          .textTheme
///          .button
///          .copyWith(color: Colors.red),
///        ): () {
///          debugPrint("You have pressed 'Hello 1'");
///        },
///        Text("Hello 2"): () {
///          debugPrint("You have pressed 'Hello 2'");
///        },
///      },
///    );
void showPopupDialog(BuildContext context, String title, String content,
    Map<Text, Function> actions) {
  List<Widget> popupActionList = [];
  actions = actions ?? {};

  // iOS Specific use CupertinoDialog
  if (Platform.isIOS) {
    // Build the actionList
    actions.forEach(
      (action, callback) {
        popupActionList.add(
          CupertinoDialogAction(
              child: action,
              onPressed: () {
                Navigator.of(context).pop();
                callback();
              }),
        );
      },
    );

    //Protect agains nulls
    if (popupActionList.isEmpty) {
      popupActionList.add(
        CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      );
    }

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var contentText;
        if (content != null) {
          contentText = Text(content);
        }
        return CupertinoAlertDialog(
          title: Text(title ?? ''),
          content: contentText,
          actions: popupActionList,
        );
      },
    );

    //Android specific or others use Material dialog
  } else {
    // Build the actionList
    actions.forEach(
      (text, callback) {
        popupActionList.add(
          FlatButton(
              child: text,
              onPressed: () {
                Navigator.of(context).pop();
                callback();
              }),
        );
      },
    );

    //Protect agains nulls
    if (popupActionList == null || popupActionList.isEmpty) {
      popupActionList.add(
        FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      );
    }

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var contentText;
        if (content != null) {
          contentText = Text(content,
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Color(0xFF2D2D2D)));
        }
        return AlertDialog(
            title: Text(title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Color(0xFF2D2D2D))),
            content: contentText,
            actions: popupActionList);
      },
    );
  }
}
