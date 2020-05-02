import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  final text, onPressed;
  AnswerButton({this.text, this.onPressed});

  @override
  _AnswerButtonState createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 100),
        lowerBound: 0.0,
        upperBound: 0.03)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - _animationController.value;

    return GestureDetector(
      onTap: () {
        _animationController.forward().then((f) {
          _animationController.reverse();
          widget.onPressed();
        });
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: Transform.scale(
        scale: scale,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: 50),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: RichText(
              text: TextSpan(
                  text: '${widget.text}',
                  style: Theme.of(context).textTheme.button),
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0x50000000), offset: Offset(2, 2), blurRadius: 2)
            ],
            color: Theme.of(context).buttonColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
