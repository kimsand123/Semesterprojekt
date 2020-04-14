import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final TextEditingController _controller;
  final String _hintText;
  final bool _isInputHidden;
  final String _caption;
  final EdgeInsets _margin;
  final int _maxLength;
  final TextInputType _inputType;
  final VoidCallback _editingCompleteCallback;
  final FormFieldValidator<String> _fieldValidator;
  final FocusNode _focusNode;
  final Function _onSave;
  final Function _onFieldSubmitted;
  final TextInputAction _textInputAction;
  final TextCapitalization _textCapitalization;

  TextFieldComponent({
    TextEditingController controller,
    String hintText,
    bool isInputHidden,
    String caption,
    EdgeInsets margin,
    int maxLength,
    TextInputType inputType,
    VoidCallback editingCompleteCallback,
    FormFieldValidator<String> fieldValidator,
    FocusNode focusNode,
    Function onSave,
    Function onFieldSubmitted,
    TextInputAction textInputAction,
    TextCapitalization textCapitalization,
  })  : this._controller = controller ?? TextEditingController(),
        this._hintText = hintText ?? '',
        this._isInputHidden = isInputHidden ?? false,
        this._caption = caption ?? '',
        this._margin = margin ?? EdgeInsets.zero,
        this._maxLength = maxLength ?? 30,
        this._inputType = inputType ?? TextInputType.text,
        this._editingCompleteCallback = editingCompleteCallback,
        this._fieldValidator = fieldValidator,
        this._focusNode = focusNode ?? FocusNode(),
        this._onSave = onSave,
        this._onFieldSubmitted = onFieldSubmitted,
        this._textInputAction = textInputAction ?? TextInputAction.done,
        this._textCapitalization =
            textCapitalization ?? TextCapitalization.words;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(_caption, style: Theme.of(context).textTheme.body2),
      Container(
        margin: _margin,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(10.0)),
        child: TextFormField(
          style: Theme.of(context)
              .textTheme
              .body1
              .copyWith(color: Color(0xFF000000)),
          keyboardType: _inputType,
          maxLength: _maxLength,
          controller: _controller,
          obscureText: _isInputHidden,
          decoration: InputDecoration(
            hintText: _hintText,
            counterText: '',
            border: InputBorder.none,
          ),
          onEditingComplete: _editingCompleteCallback,
          textInputAction: _textInputAction,
          validator: _fieldValidator,
          textCapitalization: _textCapitalization,
          onSaved: _onSave,
          onFieldSubmitted: _onFieldSubmitted,
          focusNode: _focusNode,
        ),
      ),
    ]);
  }
}
