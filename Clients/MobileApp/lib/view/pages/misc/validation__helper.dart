import 'package:flutter/cupertino.dart';
import 'package:golfquiz_dtu/localization/appLocalizations.dart';

class ValidationHelper {
  static String validateUsername(String value, BuildContext context) {
    Pattern pattern = r'^s([0-9]{6})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return AppLocalization.of(context).validation__enter_valid_username;
    else
      return null;
  }

  static String validatePassword(String arg, BuildContext context) {
    if (arg.length < 6)
      return AppLocalization.of(context).validation__too_short_password;
    else
      return null;
  }

  static String validateMatchName(String arg, BuildContext context) {
    if (arg.length < 2)
      return AppLocalization.of(context).validation__too_short(
          AppLocalization.of(context).create_match__match_name, 2);
    else if (arg.length >= 20)
      return AppLocalization.of(context).validation__too_long(
          AppLocalization.of(context).create_match__match_name, 20);
    else
      return null;
  }
}
