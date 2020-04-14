import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/user.dart';
import 'package:golfquiz/network/remote_helper.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/auth__components/auth_button__component.dart';
import 'package:golfquiz/view/components/auth__components/borderless_button__component.dart';
import 'package:golfquiz/view/components/text_field__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz/view/pages/misc/validation__helper.dart';

class SignupPage extends BasePage {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends BasePageState<SignupPage> with BasicPage {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate;
  FocusNode _nameFocus;
  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  FocusNode _confirmPasswordFocus;
  FocusNode _countryFocus;
  FocusNode _dguNumberFocus;

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  TextEditingController _countryController;
  TextEditingController _dguNumberController;

  String newDGUText;

  @override
  void initState() {
    super.initState();

    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
    _countryFocus = FocusNode();
    _dguNumberFocus = FocusNode();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _countryController = TextEditingController();
    _dguNumberController = TextEditingController();
    _dguNumberController.addListener(() => {autoCompleteDGU()});

    newDGUText = '';

    _nameController.text = 'TorbenTest';
    _emailController.text = 'torben@test.com';
    _passwordController.text = 'torbenTest123';
    _confirmPasswordController.text = 'torbenTest123';
    _countryController.text = 'Denmark';
    _dguNumberController.text = '00-000';
    _autoValidate = false;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _countryController.dispose();
    _dguNumberController.dispose();
  }

  @override
  String title() => appLocale().auth_signup__title;

  //TODO: Extract because it is the same as edit_profile_page.dart
  void autoCompleteDGU() {
    String text = _dguNumberController.text;
    if (text.length < newDGUText.length) {
      // handling backspace in keyboard
      newDGUText = text;
    } else if (text.isNotEmpty && text != newDGUText) {
      // handling typing new characters.
      String tempText = text.replaceAll("-", "");
      if (tempText.length == 2) {
        //do your text transforming
        newDGUText = '$text-';
        _dguNumberController.text = newDGUText;
        _dguNumberController.selection = new TextSelection(
            baseOffset: newDGUText.length, extentOffset: newDGUText.length);
      }
    }
  }

  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Form(
          autovalidate: _autoValidate,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextFieldComponent(
                controller: _nameController,
                isInputHidden: false,
                caption: appLocale().auth_signup__username_caption,
                hintText: appLocale().auth_signup__username_hint,
                maxLength: 20,
                inputType: TextInputType.text,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                focusNode: _nameFocus,
                textInputAction: TextInputAction.next,
                fieldValidator: (arg) {
                  return ValidationHelper.validateName(arg, context);
                },
                onFieldSubmitted: (term) {
                  fieldFocusChange(this._nameFocus, this._emailFocus);
                },
              ),
              TextFieldComponent(
                controller: _emailController,
                isInputHidden: false,
                caption: appLocale().auth__email_caption,
                hintText: appLocale().auth__email_hint,
                maxLength: 255,
                inputType: TextInputType.emailAddress,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                focusNode: _emailFocus,
                textInputAction: TextInputAction.next,
                fieldValidator: (arg) {
                  return ValidationHelper.validateEmail(arg, context);
                },
                onFieldSubmitted: (term) {
                  fieldFocusChange(this._emailFocus, this._passwordFocus);
                },
              ),
              TextFieldComponent(
                controller: _passwordController,
                isInputHidden: true,
                caption: appLocale().auth__password_caption,
                hintText: appLocale().auth__password_hint,
                maxLength: 255,
                inputType: TextInputType.visiblePassword,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                focusNode: _passwordFocus,
                textInputAction: TextInputAction.next,
                fieldValidator: (arg) {
                  return ValidationHelper.validatePassword(arg, context);
                },
                onFieldSubmitted: (term) {
                  fieldFocusChange(
                      this._passwordFocus, this._confirmPasswordFocus);
                },
              ),
              TextFieldComponent(
                controller: _confirmPasswordController,
                isInputHidden: true,
                caption: appLocale().auth_signup__confirm_password_caption,
                hintText: appLocale().auth__password_hint,
                maxLength: 255,
                inputType: TextInputType.visiblePassword,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                focusNode: _confirmPasswordFocus,
                textInputAction: TextInputAction.next,
                fieldValidator: (arg) {
                  return ValidationHelper.validateConfirmPassword(
                      arg, _passwordController.text, context);
                },
                onFieldSubmitted: (term) {
                  fieldFocusChange(
                      this._confirmPasswordFocus, this._countryFocus);
                },
              ),
              TextFieldComponent(
                controller: _countryController,
                isInputHidden: false,
                caption: appLocale().auth_signup__country_caption,
                hintText: appLocale().auth_signup__country_hint,
                maxLength: 255,
                inputType: TextInputType.text,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                focusNode: _countryFocus,
                textInputAction: TextInputAction.next,
                fieldValidator: (arg) {
                  return ValidationHelper.validateCountry(arg, context);
                },
                onFieldSubmitted: (term) {
                  fieldFocusChange(this._countryFocus, this._dguNumberFocus);
                },
              ),
              TextFieldComponent(
                controller: _dguNumberController,
                isInputHidden: false,
                caption: appLocale().auth_signup__dgu_number_caption,
                hintText: appLocale().auth_signup__dgu_number_hint,
                maxLength: 6,
                inputType: TextInputType.number,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                focusNode: _dguNumberFocus,
                textInputAction: TextInputAction.done,
                fieldValidator: (arg) {
                  return ValidationHelper.validateDguNumber(arg, context);
                },
                onFieldSubmitted: (term) {
                  setState(() {
                    this._dguNumberFocus.unfocus();
                    _autoValidate = true;
                  });
                },
              ),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            AuthButtonComponent(
              text: Text(appLocale().auth__signup_button,
                  style: appTheme().textTheme.button),
              onPressed: () => _validateAndSaveInputs(),
            ),
            BorderlessButtonComponent(
              text: Text(
                appLocale().auth__terms_button,
                style: appTheme().textTheme.button,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, termsRoute);
              },
              margin: EdgeInsets.only(top: 8.0, bottom: 20.0),
            )
          ],
        )
      ],
    );
  }

  _validateAndSaveInputs() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        enableProgressIndicator(appLocale().auth_signup__progress_text);
      });

      await Future.delayed(Duration(seconds: 1));
      setState(() {
        disableProgressIndicator();

        User _user = User(
          //Load via recieved user
          id: 0,
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          country: _countryController.text,
          handicap: 10,
          dguNumber: _dguNumberController.text,
        );

        RemoteHelper().fakeFillProviders(context, _user);

        Navigator.pushNamedAndRemoveUntil(context, gameRoute,
            ModalRoute.withName(Navigator.defaultRouteName));
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
