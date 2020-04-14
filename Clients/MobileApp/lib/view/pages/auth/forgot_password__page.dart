import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/auth__components/auth_button__component.dart';
import 'package:golfquiz/view/components/text_field__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz/view/pages/misc/validation__helper.dart';

class ForgotPasswordPage extends BasePage {
  final enteredEmail;
  ForgotPasswordPage({this.enteredEmail});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends BasePageState<ForgotPasswordPage>
    with BasicPage {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate;
  FocusNode _emailFocus;

  TextEditingController _emailController = TextEditingController();
  String _lockAnimationState;
  bool _isPaused;

  @override
  void initState() {
    super.initState();
    _lockAnimationState = 'unlock';
    _isPaused = true;
    _emailController.text = '${widget.enteredEmail}';
    _emailFocus = FocusNode();
    _autoValidate = false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  String title() => appLocale().auth_forgot_password__title;

  @override
  Widget body() {
    return Form(
      autovalidate: _autoValidate,
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth() * 0.25),
            height: screenHeight() * 0.2,
            child: Container(
                child: FlareActor(
              'assets/animations/unlock_password.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              isPaused: _isPaused,
              animation: _lockAnimationState,
            )),
          ),
          TextFieldComponent(
            inputType: TextInputType.emailAddress,
            controller: _emailController,
            caption: appLocale().auth_forgot_password__email_caption,
            isInputHidden: false,
            margin: EdgeInsets.only(bottom: 12.0, top: 8.0),
            hintText: appLocale().auth__email_hint,
            focusNode: this._emailFocus,
            fieldValidator: (arg) {
              return ValidationHelper.validateEmail(arg, context);
            },
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (term) {
              setState(() {
                _emailFocus.unfocus();
                _autoValidate = true;
              });
            },
          ),
          AuthButtonComponent(
            margin: EdgeInsets.only(top: 20.0),
            text: Text(appLocale().auth_forgot_password__reset_password_button,
                style: appTheme().textTheme.button),
            onPressed: () {
              _validateAndSaveInputs();
            },
          ),
        ],
      ),
    );
  }

  _validateAndSaveInputs() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        enableProgressIndicator(
            appLocale().auth_forgot_password__progress_text);
        _isPaused = false;
        _lockAnimationState = 'unlock';
      });

      await Future.delayed(Duration(seconds: 1));

      setState(() {
        disableProgressIndicator();
      });

      Navigator.pop(context);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
