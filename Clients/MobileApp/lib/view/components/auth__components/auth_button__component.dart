import 'package:flutter/material.dart';

class AuthButtonComponent extends StatelessWidget {
  final VoidCallback _onPressed;
  final Text _text, _errorText;
  final EdgeInsets _margin;

  AuthButtonComponent(
      {VoidCallback onPressed, Text text, Text errorText, EdgeInsets margin})
      : this._onPressed = onPressed,
        this._text = text,
        this._errorText = errorText,
        this._margin = margin;
  @override
  Widget build(BuildContext context) {
    bool _buttonIsDisabled = _onPressed == null;
    Widget _errorTextWidget;

    if (_buttonIsDisabled) {
      _errorTextWidget = _errorText;
    } else {
      _errorTextWidget = Container();
    }

    return Container(
      margin: _margin,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 75,
            height: 50,
            child: RawMaterialButton(
                elevation: _buttonIsDisabled ? 0 : 2,
                child: _text,
                onPressed: _buttonIsDisabled ? null : _onPressed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                fillColor: _buttonIsDisabled
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).colorScheme.surface),
          ),
          SizedBox(
            height: 6,
          ),
          _errorTextWidget ?? Container()
        ],
      ),
    );
  }
}
