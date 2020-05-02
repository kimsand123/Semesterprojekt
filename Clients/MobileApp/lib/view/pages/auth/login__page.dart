import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/network/auth_service.dart';
import 'package:golfquiz/network/game_service.dart';
import 'package:golfquiz/network/remote_helper.dart';
import 'package:golfquiz/network/user_service.dart';
import 'package:golfquiz/providers/friend__provider.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/auth__components/auth_button__component.dart';
import 'package:golfquiz/view/components/auth__components/borderless_button__component.dart';
import 'package:golfquiz/view/components/text_field__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz/view/pages/misc/validation__helper.dart';
import 'package:provider/provider.dart';

class LoginPage extends BasePage {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage> with BasicPage {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate;
  FocusNode _usernameFocus;
  FocusNode _passwordFocus;
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController.text = 's160198';
    _passwordController.text = 'densikkrestekode';
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
    _autoValidate = false;
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  String title() => appLocale().auth_login__title;

  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.25),
          height: MediaQuery.of(context).size.height * 0.35,
          child: Image(image: AssetImage('assets/images/golf_intro_logo.png')),
        ),
        Form(
          autovalidate: this._autoValidate,
          key: this._formKey,
          child: Column(
            children: <Widget>[
              TextFieldComponent(
                inputType: TextInputType.text,
                controller: _usernameController,
                caption: appLocale().auth__username_caption,
                isInputHidden: false,
                margin: EdgeInsets.only(bottom: 12.0, top: 8.0),
                hintText: appLocale().auth__email_hint,
                focusNode: this._usernameFocus,
                fieldValidator: (arg) {
                  return ValidationHelper.validateUsername(arg, context);
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term) {
                  fieldFocusChange(this._usernameFocus, this._passwordFocus);
                },
              ),
              TextFieldComponent(
                controller: _passwordController,
                caption: appLocale().auth__password_caption,
                isInputHidden: true,
                margin: EdgeInsets.only(bottom: 12.0, top: 8.0),
                hintText: appLocale().auth__password_hint,
                focusNode: this._passwordFocus,
                fieldValidator: (arg) {
                  return ValidationHelper.validatePassword(arg, context);
                },
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (term) {
                  setState(() {
                    _passwordFocus.unfocus();
                    _autoValidate = true;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: BorderlessButtonComponent(
            padding: EdgeInsets.only(right: 0, bottom: 8, left: 8, top: 8),
            margin: EdgeInsets.only(right: 20),
            text: Text(appLocale().auth_login__reset_password_button,
                style: appTheme()
                    .textTheme
                    .button
                    .copyWith(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pushNamed(context, forgotPasswordRoute,
                  arguments: _usernameController.text);
            },
          ),
        ),
        AuthButtonComponent(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          text: Text(appLocale().auth_login__login_button,
              style: appTheme().textTheme.button),
          onPressed: () async {
            await _validateAndSaveInputs();
          },
        ),
        BorderlessButtonComponent(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
          text: Text(appLocale().auth__terms_button,
              style: appTheme().textTheme.button),
          onPressed: () {
            Navigator.pushNamed(context, termsRoute);
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _validateAndSaveInputs() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        enableProgressIndicator(appLocale().auth_login__progress_text);
      });

      Player _user = await AuthService.login(
          _usernameController.text, _passwordController.text);

      setState(() {
        disableProgressIndicator();
      });

      RemoteHelper().fakeFillProviders(context, _user);

      //TODO: Should be moved to update GET USERS / FRIENDS
      List<Player> userlist = await UserService.fetchUsers();
      Provider.of<FriendProvider>(context, listen: false)
          .setFriendList(userlist);

      Player player = Provider.of<UserProvider>(context, listen: false).getUser;

      List<Game> games = await GameService.fetchGames(player);

      for (var game in games) {
        print(game.toJson().toString());
      }

      Navigator.pushNamedAndRemoveUntil(
          context, gameRoute, ModalRoute.withName(Navigator.defaultRouteName));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
