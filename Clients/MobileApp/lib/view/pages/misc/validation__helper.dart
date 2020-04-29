import 'package:flutter/cupertino.dart';
import 'package:golfquiz/localization/appLocalizations.dart';

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

  static String validateConfirmPassword(
      String arg, String confirmArg, BuildContext context) {
    if (arg.isEmpty)
      return AppLocalization.of(context).validation__reenter_password;
    else if (confirmArg != arg)
      return AppLocalization.of(context).validation__password_not_the_same;
    else
      return null;
  }

  static String validateName(String arg, BuildContext context) {
    if (arg.length < 2)
      return AppLocalization.of(context)
          .validation__too_short(AppLocalization.of(context).name, 2);
    else if (arg.length >= 20)
      return AppLocalization.of(context)
          .validation__too_long(AppLocalization.of(context).name, 20);
    else
      return null;
  }

  static String validateGroupName(String arg, BuildContext context) {
    if (arg.length < 2)
      return AppLocalization.of(context)
          .validation__too_short(AppLocalization.of(context).name, 2);
    else if (arg.length >= 20)
      return AppLocalization.of(context)
          .validation__too_long(AppLocalization.of(context).name, 20);
    else
      return null;
  }

  static String validateSearchName(String arg, BuildContext context) {
    if (arg.length == 0)
      return AppLocalization.of(context).validation__enter_name;
    else if (arg.length < 2)
      return AppLocalization.of(context)
          .validation__too_short(AppLocalization.of(context).name, 2);
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

  static String validateCountry(String arg, BuildContext context) {
    if (arg.length < 2)
      return AppLocalization.of(context)
          .validation__too_short(AppLocalization.of(context).country, 2);
    else if (arg.length >= 20)
      return AppLocalization.of(context)
          .validation__too_long(AppLocalization.of(context).country, 20);
    else
      return null;
  }

  static String validateDguNumber(String arg, BuildContext context) {
    if (arg.length != 6)
      return AppLocalization.of(context).validation__dgu_number;
    else
      return null;
  }
}
