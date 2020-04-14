import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'notification_bubble__component.dart';

class NotificationButton extends StatelessWidget {
  final String _title;
  final VoidCallback _onTap;

  NotificationButton({@required String title, VoidCallback onTap})
      : this._title = title,
        this._onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white70,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: <Widget>[
              NotificationBubble(),
              SizedBox(
                width: 10,
              ),
              Text(
                _title,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
