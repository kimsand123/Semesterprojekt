import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  //NB: Remember that the get name and 'name' must be the same

  /*
  ------------------------------ General ----------------------------------
  */

  String get save {
    return Intl.message('Save', name: 'save');
  }

  String get yes {
    return Intl.message('Yes', name: 'yes');
  }

  String get no {
    return Intl.message('No', name: 'no');
  }

  String get ok {
    return Intl.message('Ok', name: 'ok');
  }

  String get exit {
    return Intl.message('Exit', name: 'exit');
  }

  String get secs {
    return Intl.message('Sec', name: 'secs');
  }

  String get mins {
    return Intl.message('Min', name: 'mins');
  }

  String get hours {
    return Intl.message('Hours', name: 'hours');
  }

  String get days {
    return Intl.message('Days', name: 'days');
  }

  String get resume {
    return Intl.message('Resume', name: 'resume');
  }

  String get player {
    return Intl.message('Player', name: 'player');
  }

  String get handicap {
    return Intl.message('Handicap', name: 'handicap');
  }

  String get points {
    return Intl.message('Points', name: 'points');
  }

  String get hole {
    return Intl.message('Hole', name: 'hole');
  }

  String get you {
    return Intl.message('You', name: 'you');
  }

  String get name {
    return Intl.message('Name', name: 'name');
  }

  String get email {
    return Intl.message('Email', name: 'email');
  }

  String get status {
    return Intl.message('Status', name: 'status');
  }

  /*
  ------------------------------ AUTH ----------------------------------
  */

  String get auth__username_hint {
    return 'ex. s123456';
  }

  String get auth__password_hint {
    return '* * * * * * * * * *';
  }

  String get auth__username_caption {
    return Intl.message('Username', name: 'auth__username_caption');
  }

  String get auth__password_caption {
    return Intl.message('Password', name: 'auth__password_caption');
  }

  String get auth_intro__title {
    return 'GolfQuis (DTU)';
  }

  String get auth_intro__login_button {
    return Intl.message('Login', name: 'auth_intro__login_button');
  }

  String get auth_login__title {
    return Intl.message('Login', name: 'auth_login__title');
  }

  String get auth_login__reset_password_button {
    return Intl.message('Reset password',
        name: 'auth_login__reset_password_button');
  }

  String get auth_login__login_button {
    return Intl.message('Login', name: 'auth_login__login_button');
  }

  String get auth_login__progress_text {
    return Intl.message('Signing you in...', name: 'auth_login__progress_text');
  }

  /*
  ------------------------------ Menu ----------------------------------
  */

  String get menu__profile_button {
    return Intl.message('Profile', name: 'menu__profile_button');
  }

  String get menu__friends_button {
    return Intl.message('Friends', name: 'menu__friends_button');
  }

  String get menu__log_out_button {
    return Intl.message('Log out', name: 'menu__log_out_button');
  }

  /*
  ------------------------------ Friends ----------------------------------
  */

  String get friends__title {
    return Intl.message('Friends', name: 'friends__title');
  }

  String get friends__list_first_title {
    return Intl.message('Player', name: 'friends__list_first_title');
  }

  /*
  ------------------------------ Game flow ----------------------------------
  */

  String get groups__group_list__first_title {
    return Intl.message('Group name', name: 'groups__group_list__first_title');
  }

  String get groups__group_list__second_title {
    return Intl.message('Avg. handicap',
        name: 'groups__group_list__second_title');
  }

  String get game_flow__seconds_short {
    return Intl.message('Sec.', name: 'game_flow__seconds_short');
  }

  String get game_flow__minutes_short {
    return Intl.message('Min.', name: 'game_flow__minutes_short');
  }

  String get game_flow__hours_short {
    return Intl.message('Hours', name: 'game_flow__hours_short');
  }

  String get game_flow__days_short {
    return Intl.message('Days', name: 'game_flow__days_short');
  }

  /*
  ------------------------------ Game appbar --------------------------------
  */

  String get game_appbar__question_duration {
    return Intl.message('Q. duration', name: 'game_appbar__question_duration');
  }

  String get game_appbar__your_score {
    return Intl.message('Your score', name: 'game_appbar__your_score');
  }

  /*
  ------------------------------ Input validation ---------------------------
  */

  String get validation__enter_valid_username {
    return Intl.message("Enter valid username - ex. 's123456'",
        name: 'validation__enter_valid_username');
  }

  String get validation__too_short_password {
    return Intl.message('Password must be more than 6 characters',
        name: 'validation__too_short_password');
  }

  String validation__too_short(tooShort, length) =>
      Intl.message('$tooShort should be at least $length letters',
          name: 'validation__too_short', args: [tooShort, length]);

  String validation__too_long(tooLong, length) =>
      Intl.message('$tooLong should be under $length letters',
          name: 'validation__too_long', args: [tooLong, length]);

  /*
  ------------------------------ Game list ----------------------------------
  */

  String get game_list__two_player_matches {
    return Intl.message('Two player matches',
        name: 'game_list__two_player_matches');
  }

  String get game_list__active_matches {
    return Intl.message('Active matches', name: 'game_list__active_matches');
  }

  String get game_list__inactive_matches {
    return Intl.message('Previous matches',
        name: 'game_list__inactive_matches');
  }

  /*
  ------------------------------ Components ----------------------------------
*/
  String get active_games_card__show_all_matches {
    return Intl.message('Show all matches',
        name: 'active_games_card__show_all_matches');
  }

  String get progressbar_text {
    return Intl.message('Your progress', name: 'progressbar_text');
  }

  /*
  ------------------------------ Bottom navigation - Game ----------------------------------
*/

  String get games__title {
    return Intl.message('Games', name: 'games__title');
  }

  String get games__start_new_match {
    return Intl.message('Start new match', name: 'games__start_new_match');
  }

  String get games__start_new_match__two_player_match {
    return Intl.message('Two player match',
        name: 'games__start_new_match__two_player_match');
  }

  String get games__your_matches {
    return Intl.message('Your matches', name: 'games__your_matches');
  }

  String get games__your_matches__two_player_matches {
    return Intl.message('Two player matches',
        name: 'games__your_matches__two_player_matches');
  }

/*
  ------------------------------ Bottom navigation - Menu ----------------------------------
*/

  String get menu__title {
    return Intl.message('Menu', name: 'menu__title');
  }

  String get menu__email_error {
    return Intl.message('No email found?', name: 'menu__email_error');
  }

/*
  ------------------------------ Bottom navigation - Menu ----------------------------------
*/

  String get bottom_navigation__games {
    return Intl.message('Games', name: 'bottom_navigation__games');
  }

  String get bottom_navigation__menu {
    return Intl.message('Menu', name: 'bottom_navigation__menu');
  }

/*
  ------------------------------ Game flow - Create match ----------------------------------
*/

  String get create_match__title__two_player_match {
    return Intl.message('Two player',
        name: 'create_match__title__two_player_match');
  }

  String get create_match__match_name {
    return Intl.message('Match name', name: 'create_match__match_name');
  }

  String get create_match__match_name__hint_text {
    return Intl.message('ex. Super match',
        name: 'create_match__match_name__hint_text');
  }

  String get create_match__question_duration {
    return Intl.message('Question duration',
        name: 'create_match__question_duration');
  }

  String get create_match__question_duration__custom {
    return Intl.message('Custom duration',
        name: 'create_match__question_duration__custom');
  }

  String create_match__question_duration__seconds(int seconds) =>
      Intl.message('${seconds}s',
          name: 'create_match__question_duration__seconds', args: [seconds]);

  String get create_match__player_invite {
    return Intl.message('Invite players', name: 'create_match__player_invite');
  }

  String get create_match__player_invite__friends {
    return Intl.message('Friend', name: 'create_match__player_invite__friends');
  }

/*
  ------------------------------ Game flow - Question ----------------------------------
*/

  String get game_flow__question__title {
    return Intl.message('GolfQuiz', name: 'game_flow__question__title');
  }

  String get game_flow__question__q_duration {
    return Intl.message('Q. duration', name: 'game_flow__question__q_duration');
  }

  String get game_flow__question__your_score {
    return Intl.message('Your score', name: 'game_flow__question__your_score');
  }

/*
  ------------------------------ Game flow - Question ----------------------------------
*/
  String game_flow__result__hole(int gameProgress) =>
      Intl.message('Hole ${gameProgress}',
          name: 'game_flow__result__hole', args: [gameProgress]);

  String game_flow__result__rule(String ruleString) =>
      Intl.message('Rule ${ruleString}',
          name: 'game_flow__result__rule', args: [ruleString]);

  String get game_flow__result__scoreboard {
    return Intl.message('Scoreboard', name: 'game_flow__result__scoreboard');
  }

  String get game_flow__result__pause_dialog {
    return Intl.message('Are you sure you want to pause the game?',
        name: 'game_flow__result__pause_dialog');
  }

  String get game_flow__result__continue {
    return Intl.message('Continue', name: 'game_flow__result__continue');
  }

  String get game_flow__result__correct {
    return Intl.message('Correct', name: 'game_flow__result__correct');
  }

  String get game_flow__result__wrong {
    return Intl.message('Wrong', name: 'game_flow__result__wrong');
  }

/*
  ------------------------------ Game flow - Scoreboard ----------------------------------
*/
  String get game_flow__scoreboard__q_duration {
    return Intl.message('Q. duration',
        name: 'game_flow__scoreboard__q_duration');
  }

  String get game_flow__scoreboard__your_score {
    return Intl.message('Your score',
        name: 'game_flow__scoreboard__your_score');
  }

  String get game_flow__scoreboard__end_game {
    return Intl.message('End game', name: 'game_flow__scoreboard__end_game');
  }

  String get game_flow__scoreboard__pause_dialog {
    return Intl.message('Are you sure you want to pause the game?',
        name: 'game_flow__scoreboard__pause_dialog');
  }

  String get game_flow__scoreboard__resume {
    return Intl.message('Resume', name: 'game_flow__scoreboard__resume');
  }

  String get game_flow__scoreboard__points {
    return Intl.message('Points', name: 'game_flow__scoreboard__points');
  }

  String get game_flow__scoreboard__player {
    return Intl.message('Player', name: 'game_flow__scoreboard__player');
  }

/*
  ------------------------------ Invite helper ----------------------------------
*/
  String invite_helper__max_players(int maxPlayersTwoPlayerMatch) =>
      Intl.message('Max $maxPlayersTwoPlayerMatch players reached',
          name: 'invite_helper__max_players', args: [maxPlayersTwoPlayerMatch]);

  String invite_helper__two_player__dialog_text(String name) => Intl.message(
      'Two-player match can only contain two players. Remove $name to add a different player.',
      name: 'invite_helper__two_player__dialog_text',
      args: [name]);

  /*
  ------------------------------ Profile ----------------------------------
*/

  String get profile__title {
    return Intl.message('My profile', name: 'profile__title');
  }

  /*
  ------------------------------ Errors ----------------------------------
  */

  String get error__data_was_not_recieved {
    return Intl.message(
        'An error has occured! \nPlease contact our support team if this error keeps occuring. ',
        name: 'error__data_was_not_recieved');
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    bool isSupported = false;

    if (locale != null) {
      isSupported = locale.languageCode == 'en';
    }

    return isSupported;
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    debugPrint("Load language: " + locale.toString());

    return AppLocalization.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
