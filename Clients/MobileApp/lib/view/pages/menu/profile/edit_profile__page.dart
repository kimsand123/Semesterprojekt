import 'package:flutter/material.dart';
import 'package:golfquiz/models/user.dart';
import 'package:golfquiz/network/remote_helper.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/avatar__component.dart';
import 'package:golfquiz/view/components/text_field__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz/view/pages/misc/validation__helper.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends BasePage {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends BasePageState<EditProfilePage>
    with BasicPage {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate;
  bool _settingNewPassword;

  FocusNode _nameFocus;
  FocusNode _emailFocus;
  FocusNode _oldPasswordFocus;
  FocusNode _newPasswordFocus;
  FocusNode _newConfirmPasswordFocus;
  FocusNode _countryFocus;
  FocusNode _dguNumberFocus;

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _countryController;
  TextEditingController _oldPasswordController;
  TextEditingController _newPasswordController;
  TextEditingController _newPasswordConfirmController;
  TextEditingController _dguNumberController;

  String newDGUText;

  UserProvider _userProvider;

  @override
  void initState() {
    super.initState();

    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _oldPasswordFocus = FocusNode();
    _newPasswordFocus = FocusNode();
    _newConfirmPasswordFocus = FocusNode();
    _countryFocus = FocusNode();
    _dguNumberFocus = FocusNode();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _countryController = TextEditingController();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newPasswordConfirmController = TextEditingController();

    newDGUText = '';

    _userProvider = Provider.of<UserProvider>(context, listen: false);
    User user = _userProvider.getUser;
    _nameController.text = '${user.firstName}';
    _emailController.text = '${user.lastName}';
    _countryController.text = '${user.studyProgramme}';

    _autoValidate = false;
    _settingNewPassword = false;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmController.dispose();
    _countryController.dispose();
    _dguNumberController.dispose();
  }

  //TODO: Extract because it is the same as signup_page.dart
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
  Widget action() {
    return GestureDetector(
      onTap: () {
        onSave();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.check),
      ),
    );
  }

  @override
  Widget body() {
    return Form(
      autovalidate: _autoValidate,
      key: _formKey,
      child: Column(
        children: <Widget>[
          Consumer<UserProvider>(
            builder: (context, provider, child) {
              return AvatarComponent(
                canEditAvatar: true,
                name: appLocale().edit_profile__title,
                onPressed: () {
                  debugPrint('//TODO: Select-avatar');
                },
              );
            },
          ),
          Column(
            children: <Widget>[
              TextFieldComponent(
                controller: _nameController,
                isInputHidden: false,
                caption: appLocale().name,
                hintText: '',
                maxLength: 20,
                inputType: TextInputType.text,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                focusNode: _nameFocus,
                textInputAction: TextInputAction.done,
                fieldValidator: (arg) {
                  return ValidationHelper.validateName(arg, context);
                },
                onFieldSubmitted: (term) {
                  _nameFocus.unfocus();
                },
              ),
              TextFieldComponent(
                controller: _emailController,
                isInputHidden: false,
                caption: appLocale().email,
                hintText: '',
                maxLength: 20,
                inputType: TextInputType.text,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                focusNode: _emailFocus,
                textInputAction: TextInputAction.done,
                fieldValidator: (arg) {
                  return ValidationHelper.validateUsername(arg, context);
                },
                onFieldSubmitted: (term) {
                  _emailFocus.unfocus();
                },
              ),
              TextFieldComponent(
                controller: _countryController,
                isInputHidden: false,
                caption: appLocale().country,
                hintText: '',
                maxLength: 20,
                inputType: TextInputType.text,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                focusNode: _countryFocus,
                textInputAction: TextInputAction.done,
                fieldValidator: (arg) {
                  return ValidationHelper.validateCountry(arg, context);
                },
                onFieldSubmitted: (term) {
                  _countryFocus.unfocus();
                },
              ),
              TextFieldComponent(
                controller: _dguNumberController,
                isInputHidden: false,
                caption: appLocale().club_number,
                hintText: '00-000',
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
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 50),
          Column(
            children: <Widget>[
              TextFieldComponent(
                controller: _oldPasswordController,
                isInputHidden: true,
                caption: appLocale().edit_profile__old_password,
                hintText: '***********',
                maxLength: 20,
                inputType: TextInputType.visiblePassword,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                focusNode: _oldPasswordFocus,
                textInputAction: TextInputAction.next,
                fieldValidator: (arg) {
                  if (arg.isNotEmpty) {
                    _settingNewPassword = true;
                    return ValidationHelper.validatePassword(arg, context);
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (term) {
                  fieldFocusChange(_oldPasswordFocus, _newPasswordFocus);
                },
              ),
              TextFieldComponent(
                controller: _newPasswordController,
                isInputHidden: true,
                caption: appLocale().edit_profile__new_password,
                hintText: '***********',
                maxLength: 20,
                inputType: TextInputType.visiblePassword,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                focusNode: _newPasswordFocus,
                fieldValidator: (arg) {
                  if (_settingNewPassword) {
                    return ValidationHelper.validatePassword(arg, context);
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (term) {
                  fieldFocusChange(_newPasswordFocus, _newConfirmPasswordFocus);
                },
              ),
              TextFieldComponent(
                controller: _newPasswordConfirmController,
                isInputHidden: true,
                caption: appLocale().edit_profile__confirm_new_password,
                hintText: '***********',
                maxLength: 20,
                inputType: TextInputType.visiblePassword,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                focusNode: _newConfirmPasswordFocus,
                fieldValidator: (arg) {
                  if (_settingNewPassword) {
                    return ValidationHelper.validateConfirmPassword(
                        arg, _newPasswordController.text, context);
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (term) {
                  this._autoValidate = true;
                  _newConfirmPasswordFocus.unfocus();
                },
              ),
              SizedBox(height: 50)
            ],
          )
        ],
      ),
    );
  }

  Future<void> onSave() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        enableProgressIndicator(appLocale().edit_profile__save_loading);
      });

      await Future.delayed(Duration(seconds: 1));
      setState(() {
        disableProgressIndicator();
      });

      User user = _userProvider.getUser;
      //user.name = this._nameController.text;
      user.email = this._emailController.text;
      //user.country = this._countryController.text;

      // Send password
      debugPrint(
          'Sending new password to server: ${this._newPasswordConfirmController.text}');

      RemoteHelper().fakeFillProviders(context, user);

      Navigator.of(context).pop();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  String title() => '';
}
