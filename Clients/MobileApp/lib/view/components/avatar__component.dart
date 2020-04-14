import 'package:flutter/material.dart';

class AvatarComponent extends StatefulWidget {
  final String name;
  final bool canEditAvatar;
  final VoidCallback onPressed;

  AvatarComponent({this.name, this.canEditAvatar, this.onPressed});

  @override
  _AvatarComponentState createState() => _AvatarComponentState();
}

class _AvatarComponentState extends State<AvatarComponent> {
  @override
  Widget build(BuildContext context) {
    var editButton;

    if (widget.canEditAvatar) {
      editButton = Container(
        width: 30,
        height: 30,
        child: Icon(Icons.edit,
            color: Theme.of(context).colorScheme.onSurface, size: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0x80000000), blurRadius: 4, offset: Offset(2, 2))
          ],
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    } else {
      editButton = Container();
    }

    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(widget.name, style: Theme.of(context).textTheme.title)),
        Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/images/avatar_placeholder.png')),
            Positioned(
              top: 90,
              left: 90,
              child: GestureDetector(
                  onTap: () {
                    widget.onPressed();
                  },
                  child: editButton),
            )
          ],
        ),
      ],
    );
  }
}
