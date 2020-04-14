import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class DropdownComponent extends StatefulWidget {
  final Widget hintText;
  final List<Widget> menuItems;
  final Function callBack;
  final double listHeight;

  DropdownComponent(
      {this.menuItems,
      this.hintText,
      this.callBack,
      @required this.listHeight});

  @override
  _DropdownComponentState createState() =>
      _DropdownComponentState(hintText: hintText);
}

class _DropdownComponentState extends State<DropdownComponent>
    with SingleTickerProviderStateMixin {
  Widget hintText;
  double _height;
  String _dropdownDirection;
  bool _isExpanded;
  var _radius;

  _DropdownComponentState({
    this.hintText,
  });

  @override
  void initState() {
    super.initState();
    _height = 0.0;
    _dropdownDirection = 'idle';
    _isExpanded = false;
    _radius = 10.0;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        // Dropdown menu
        AnimatedContainer(
          margin: EdgeInsets.only(top: 40.0),
          padding: EdgeInsets.symmetric(vertical: 12.0),
          curve: Curves.easeOutQuart,
          duration: _isExpanded
              ? Duration(milliseconds: 500)
              : Duration(milliseconds: 200),
          width: screenWidth - 60,
          height: _height,
          decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x30000000),
                    blurRadius: 10,
                    offset: Offset(3, 6))
              ]),
          child: ScrollConfiguration(
            behavior: RemoveGlowBehavior(),
            child: ListView.builder(
              itemCount: widget.menuItems.length,
              itemBuilder: (context, index) {
                var dot;
                if (hintText == widget.menuItems[index]) {
                  dot = Container(
                    margin: EdgeInsets.only(right: 10.0),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF2D2D2D)),
                  );
                } else {
                  dot = Container(
                    margin: EdgeInsets.only(right: 10.0),
                    width: 5,
                    height: 5,
                  );
                }

                return GestureDetector(
                  onTap: () {
                    onItemTapped(index);
                    widget.callBack(widget.menuItems[index]);
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    width: screenWidth,
                    child: Row(
                      children: <Widget>[
                        dot,
                        widget.menuItems[index],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Clickable area
        GestureDetector(
          onTap: () {
            onTap(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: screenWidth - 60,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x30000000),
                      blurRadius: 10,
                      offset: Offset(3, 6))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                hintText,
                Container(
                    width: 35,
                    height: 35,
                    child: FlareActor(
                      'assets/animations/dropdown_arrow.flr',
                      alignment: Alignment.center,
                      animation: _dropdownDirection,
                      fit: BoxFit.contain,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  onTap(BuildContext context) {
    setState(() {
      if (_dropdownDirection == 'idle') {
        _dropdownDirection = 'up';
      } else {
        _dropdownDirection = _dropdownDirection == 'down' ? 'up' : 'down';
      }
      _radius = _radius == 0.0 ? 10.0 : 0.0;
      _height = _height == 0.0 ? setListHeight(context) : 0.0;
      _isExpanded = !_isExpanded;
    });
  }

  onItemTapped(index) {
    setState(() {
      hintText = widget.menuItems[index];
      _height = 0.0;
      _radius = _radius == 10.0 ? 0.0 : 10.0;
      _isExpanded = false;
      _dropdownDirection = 'down';
    });
  }

  setListHeight(BuildContext context) {
    if (widget.menuItems.length > 5) {
      return MediaQuery.of(context).size.height * 0.5 + 2.5;
    } else {
      return widget.menuItems.length * widget.listHeight;
    }
  }
}

class RemoveGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
