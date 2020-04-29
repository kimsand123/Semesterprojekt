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

  String get appbar__edit_button {
    return Intl.message('Edit', name: 'appbar__edit_button');
  }

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

  String get resume {
    return Intl.message('Resume', name: 'resume');
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

  String get player {
    return Intl.message('Player', name: 'player');
  }

  String get rank {
    return Intl.message('Rank', name: 'rank');
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

  String get time {
    return Intl.message('Time', name: 'time');
  }

  String get you {
    return Intl.message('You', name: 'you');
  }

  String get admin {
    return Intl.message('Admin', name: 'admin');
  }

  String get name {
    return Intl.message('Name', name: 'name');
  }

  String get email {
    return Intl.message('Email', name: 'email');
  }

  String get country {
    return Intl.message('Country', name: 'country');
  }

  String get club_number {
    return Intl.message('Club Number', name: 'club_number');
  }

  String get status {
    return Intl.message('Status', name: 'status');
  }

  String get bufferzone {
    return Intl.message('Bufferzone', name: 'bufferzone');
  }

  String get world_rank {
    return Intl.message('World rank', name: 'world_rank');
  }

  String get danish {
    return Intl.message('Danish', name: 'danish');
  }

  String get english {
    return Intl.message('English', name: 'english');
  }

  /*
  ------------------------------ Dialog ----------------------------------
  */

  String get dialog__are_you_sure {
    return Intl.message('Are you sure?', name: 'dialog__are_you_sure');
  }

  String dialog__delete_from(username, deleteFrom) =>
      Intl.message('Do you want to remove $username from $deleteFrom?',
          name: 'dialog__delete_from', args: [username, deleteFrom]);

  String dialog__delete(username) =>
      Intl.message('Do you want to remove $username from your friends?',
          name: 'dialog__delete', args: [username]);

  String dialog__delete_group(group) =>
      Intl.message('Do you want to delete the group $group?',
          name: 'dialog__delete_group', args: [group]);

  /*
  ------------------------------ Add ----------------------------------
  */

  String get add__group_members {
    return Intl.message('+ Add group members', name: 'add__group_members');
  }

  /*
  ------------------------------ AUTH ----------------------------------
  */

  String get auth__email_hint {
    return 'someone@example.com';
  }

  String get auth__password_hint {
    return '************';
  }

  String get auth__username_caption {
    return Intl.message('Username', name: 'auth__email_caption');
  }

  String get auth__password_caption {
    return Intl.message('Password', name: 'auth__password_caption');
  }

  String get auth__signup_button {
    return Intl.message('Signup', name: 'auth__signup_button');
  }

  String get auth__terms_button {
    return Intl.message('Terms and conditions', name: 'auth__terms_button');
  }

  String get auth_intro__title {
    return 'GolfQuis';
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

  String get auth_login__join_button {
    return Intl.message("Don't you have an account? Join us here",
        name: 'auth_login__join_button');
  }

  String get auth_signup__title {
    return Intl.message('Getting Started', name: 'auth_signup__title');
  }

  String get auth_signup__username_caption {
    return Intl.message('Username', name: 'auth_signup__username_caption');
  }

  String get auth_signup__username_hint {
    return Intl.message('Name', name: 'auth_signup__username_hint');
  }

  String get auth_signup__country_caption {
    return Intl.message('Country', name: 'auth_signup__country_caption');
  }

  String get auth_signup__country_hint {
    return Intl.message('Denmark', name: 'auth_signup__country_hint');
  }

  String get auth_forgot_password__title {
    return Intl.message('Forgot password', name: 'auth_forgot_password__title');
  }

  String get auth_forgot_password__email_caption {
    return Intl.message('Enter your email adress',
        name: 'auth_forgot_password__email_caption');
  }

  String get auth_forgot_password__reset_password_button {
    return Intl.message('Reset password',
        name: 'auth_forgot_password__reset_password_button');
  }

  String get auth_signup__confirm_password_caption {
    return Intl.message('Confirm password',
        name: 'auth_signup__confirm_password_caption');
  }

  String get auth_signup__dgu_number_caption {
    return Intl.message('Club number', name: 'auth_signup__dgu_number_caption');
  }

  String get auth_signup__dgu_number_hint {
    return Intl.message('00-000', name: 'auth_signup__dgu_number_hint');
  }

  String get auth_forgot_password__progress_text {
    return Intl.message('Sending a password your way...',
        name: 'auth_forgot_password__progress_text');
  }

  String get auth_login__progress_text {
    return Intl.message('Signing you in...', name: 'auth_login__progress_text');
  }

  String get auth_signup__progress_text {
    return Intl.message('Signing you up...',
        name: 'auth_signup__progress_text');
  }

  /*
  ------------------------------ Menu ----------------------------------
  */

  String get menu__status_button {
    return Intl.message('Status', name: 'menu__status_button');
  }

  String get menu__profile_button {
    return Intl.message('Profile', name: 'menu__profile_button');
  }

  String get menu__friends_button {
    return Intl.message('Friends', name: 'menu__friends_button');
  }

  String get menu__group_button {
    return Intl.message('Groups', name: 'menu__group_button');
  }

  String get menu__club_button {
    return Intl.message('Club', name: 'menu__club_button');
  }

  String get menu__settings_section {
    return Intl.message('Settings', name: 'menu__settings_section');
  }

  String get menu__app_settings_button {
    return Intl.message('App settings', name: 'menu__app_settings_button');
  }

  String get menu__help_and_feedback_button {
    return Intl.message('Help and feedback',
        name: 'menu__help_and_feedback_button');
  }

  String get menu__about_button {
    return Intl.message('About', name: 'menu__about_button');
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

  String get friends__notification {
    return Intl.message('New friend request', name: 'friends__notification');
  }

  String get friends__add_friends_button {
    return Intl.message('+ Add new friends',
        name: 'friends__add_friends_button');
  }

  String get friends__list_first_title {
    return Intl.message('Player', name: 'friends__list_first_title');
  }

  String get friends__list_second_title {
    return Intl.message('Handicap', name: 'friends__list_second_title');
  }

  /*
  ------------------------------ Groups ----------------------------------
  */

  String get groups__title {
    return Intl.message('Groups', name: 'groups__title');
  }

  String get groups__notification {
    return Intl.message('New group invite', name: 'groups__notification');
  }

  String get groups__create_new_group {
    return Intl.message('+ Create new group', name: 'groups__create_new_group');
  }

  String get groups__create_group_title {
    return Intl.message('Create group', name: 'groups__create_group_title');
  }

  String get groups__single_group_list__first_title {
    return Intl.message('Player',
        name: 'groups__single_group_list__first_title');
  }

  String get groups__single_group_list__second_title {
    return Intl.message('Handicap',
        name: 'groups__single_group_list__second_title');
  }

  String get groups__group_list__first_title {
    return Intl.message('Group name', name: 'groups__group_list__first_title');
  }

  String get groups__group_list__second_title {
    return Intl.message('Avg. handicap',
        name: 'groups__group_list__second_title');
  }

  String get groups__delete_group {
    return Intl.message('Delete the group', name: 'groups__delete_group');
  }

  String get groups__saving_group_popup {
    return Intl.message('Saving the group...',
        name: 'groups__saving_group_popup');
  }
  /*
  ------------------------------ Club ----------------------------------
  */

  String get club__title {
    return Intl.message('Club', name: 'club__title');
  }

  String get club__add_club_members_button {
    return Intl.message('+ Add new club member',
        name: 'club__add_club_members_button');
  }

  String get club__group_list__first_title {
    return Intl.message('Club member', name: 'club__group_list__first_title');
  }

  String get club__group_list__second_title {
    return Intl.message('Handicap', name: 'club__group_list__second_title');
  }

  /*
  ------------------------------ Game flow ----------------------------------
  */

  String get game_flow__elaborate_rule__title {
    return Intl.message('Elaborate rule',
        name: 'game_flow__elaborate_rule__title');
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

  String get game_appbar__players {
    return Intl.message('Players', name: 'game_appbar__players');
  }

  /*
  ------------------------------ Privacy policy -----------------------------
  */

  String get privacy_policy__title {
    return Intl.message('Privacy policy', name: 'privacy_policy__title');
  }

  /*
  ------------------------------ Terms and conditions -----------------------
  */

  String get terms_conditions__title {
    return Intl.message('Terms & Conditions', name: 'terms_conditions__title');
  }

  /*
  ------------------------------ Upcoming tournaments -----------------------
  */

  String get game_tournaments__start {
    return Intl.message('Starts', name: 'game_tournaments__start');
  }

  String get game_tournaments__are_you_sure {
    return Intl.message('Are you sure you want to join this tournament?',
        name: 'game_tournaments__are_you_sure');
  }

  String get game_tournaments__ongoing_tournaments {
    return Intl.message('Ongoing Tournaments',
        name: 'game_tournaments__ongoing_tournaments');
  }

  String get game_tournaments__upcoming_tournaments {
    return Intl.message('Upcoming Tournaments',
        name: 'game_tournaments__upcoming_tournaments');
  }

  String get game_tournaments__join_tournaments {
    return Intl.message('Join tournament',
        name: 'game_tournaments__join_tournaments');
  }

  String get game_tournaments__no_tournaments {
    return Intl.message('There are no upcoming or ongoing tournaments..',
        name: 'game_tournaments__no_tournaments');
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

  String get validation__reenter_password {
    return Intl.message('Please re-enter the password',
        name: 'validation__reenter_password');
  }

  String get validation__password_not_the_same {
    return Intl.message('Password must be the same',
        name: 'validation__password_not_the_same');
  }

  String get validation__enter_name {
    return Intl.message('Enter a name to search',
        name: 'validation__enter_name');
  }

  String get validation__dgu_number {
    return Intl.message('DGU number should be 5 numbers',
        name: 'validation__dgu_number');
  }

  String validation__too_short(tooShort, length) =>
      Intl.message('$tooShort should be at least $length letters',
          name: 'validation__too_short', args: [tooShort, length]);

  String validation__too_long(tooLong, length) =>
      Intl.message('$tooLong should be under $length letters',
          name: 'validation__too_long', args: [tooLong, length]);

  /*
  ------------------------------ About --------------------------------------
  */

  String get about__title {
    return Intl.message('About', name: 'about__title');
  }

  String get about__copyrights_title {
    return Intl.message('Copyrights', name: 'about__copyrights_title');
  }

  String get about__copyrights {
    return Intl.message(
        "Excerpts from The Rules of Golf and interpretations are reprinted with permission. \n\nCopyright \u00a9 (2019) R&A Rules Limited. All rights reserved. All rules questions Copyright \u00a9 (2019) GolfQuiz / Appicorn ApS. All rights reserved",
        name: 'about__copyrights');
  }

  String get about__policies_title {
    return Intl.message('Policies', name: 'about__policies_title');
  }

  String get about__policies_privacy_button {
    return Intl.message('Privacy policy',
        name: 'about__policies_privacy_button');
  }

  String get about__policies_terms_button {
    return Intl.message('Terms & Conditions',
        name: 'about__policies_terms_button');
  }

  String get about__about_app_title {
    return Intl.message('About this app', name: 'about__about_app_title');
  }

  String get about__about_app {
    return Intl.message(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        name: 'about__about_app');
  }

  /*
  ------------------------------ App settings -------------------------------
  */

  String get app_settings__title {
    return Intl.message('App settings', name: 'app_settings__title');
  }

  String get app_settings__audio_title {
    return Intl.message('Audio settings', name: 'app_settings__audio_title');
  }

  String get app_settings__audio {
    return Intl.message('Audio', name: 'app_settings__audio');
  }

  String get app_settings__notifications_title {
    return Intl.message('Notifications settings',
        name: 'app_settings__notifications_title');
  }

  String get app_settings__notifications {
    return Intl.message('Notifications', name: 'app_settings__notifications');
  }

  String get app_settings__privacy_title {
    return Intl.message('Privacy settings',
        name: 'app_settings__privacy_title');
  }

  String get app_settings__privacy_club {
    return Intl.message('Connect profile to club',
        name: 'app_settings__privacy_club');
  }

  String get app_settings__privacy_ranking {
    return Intl.message('Visible on ranking boards',
        name: 'app_settings__privacy_ranking');
  }

  String get app_settings__language_title {
    return Intl.message('Select language',
        name: 'app_settings__language_title');
  }

  String get app_settings__language_hint {
    return Intl.message('Language', name: 'app_settings__language_hint');
  }

  /*
  ------------------------------ Help and feedback ----------------------------
  */

  String get help_and_feedback__title {
    return Intl.message('Help & Feedback', name: 'help_and_feedback__title');
  }

  String get help_and_feedback__how_to_play_title {
    return Intl.message('How to play',
        name: 'help_and_feedback__how_to_play_title');
  }

  String get help_and_feedback__how_to_play {
    return Intl.message('Guide', name: 'help_and_feedback__how_to_play');
  }

  String get help_and_feedback__handicap_rules_title {
    return Intl.message('Golf Rule Handicap',
        name: 'help_and_feedback__handicap_rules_title');
  }

  String get help_and_feedback__handicap_rules {
    return Intl.message('Handicap rule description',
        name: 'help_and_feedback__handicap_rules');
  }

  String get help_and_feedback__contact_title {
    return Intl.message('Contact us', name: 'help_and_feedback__contact_title');
  }

  String get help_and_feedback__contact {
    return Intl.message('greenkeeper@golfquis.com',
        name: 'help_and_feedback__contact');
  }

  /*
  ------------------------------ Status--------- ----------------------------
  */

  String get status__title {
    return Intl.message('Status', name: 'status__title');
  }

  String get status__ranking_title {
    return Intl.message('Ranking', name: 'status__ranking_title');
  }

  String get status__ranking_world_overlay {
    return Intl.message('World ranking', name: 'status__ranking_world_overlay');
  }

  String get status__ranking_friends_button {
    return Intl.message('Friends rank', name: 'status__ranking_friends_button');
  }

  String get status__ranking_friends_overlay {
    return Intl.message('Friends ranking',
        name: 'status__ranking_friends_overlay');
  }

  String get status__ranking_club_button {
    return Intl.message('Club rank', name: 'status__ranking_club_button');
  }

  String get status__ranking_club_overlay {
    return Intl.message('Club ranking', name: 'status__ranking_club_overlay');
  }

  String get status__game_overview_title {
    return Intl.message('Game overview', name: 'status__game_overview_title');
  }

  String get status__games_played {
    return Intl.message('Games played', name: 'status__games_played');
  }

  String get status__games_won {
    return Intl.message('Games won', name: 'status__games_won');
  }

  String get status__games_lost {
    return Intl.message('Games lost', name: 'status__games_lost');
  }

  /*
  ------------------------------ Game list ----------------------------------
  */

  String get game_list__solo_matches {
    return Intl.message('Solo matches', name: 'game_list__solo_matches');
  }

  String get game_list__two_player_matches {
    return Intl.message('Two player matches',
        name: 'game_list__two_player_matches');
  }

  String get game_list__group_matches {
    return Intl.message('Group matches', name: 'game_list__group_matches');
  }

  String get game_list__tournaments_matches {
    return Intl.message('Tournament matches',
        name: 'game_list__tournaments_matches');
  }

  String get game_list__active_matches {
    return Intl.message('Active matches', name: 'game_list__active_matches');
  }

  String get game_list__inactive_matches {
    return Intl.message('Previous matches',
        name: 'game_list__inactive_matches');
  }

  String game_list__hole_out_of(currentHole, maxHoles) =>
      Intl.message('Hole ${currentHole} out of $maxHoles',
          name: 'game_list__hole_out_of', args: [currentHole, maxHoles]);

  String game_list__total_score(score) => Intl.message('Total score of $score',
      name: 'game_list__total_score', args: [score]);

  String game_list__date_ended_at(end) =>
      Intl.message('Ended $end', name: 'game_list__date_ended_at', args: [end]);

  String get game_list__your_turn {
    return Intl.message('Your turn');
  }

  String get game_list__their_turn {
    return Intl.message('Their turn');
  }

  String game_list__num_of_players(amountOfPlayers) =>
      Intl.message('$amountOfPlayers players',
          name: 'game_list__num_of_players', args: [amountOfPlayers]);

  String game_list__seconds_left(seconds) =>
      Intl.message('$seconds seconds left',
          name: 'game_list__seconds_left', args: [seconds]);
  String game_list__minutes_left(minutes) =>
      Intl.message('$minutes minutes left',
          name: 'game_list__minutes_left', args: [minutes]);
  String game_list__hours_left(hours) => Intl.message('$hours hours left',
      name: 'game_list__hours_left', args: [hours]);
  String game_list__days_left(days) => Intl.message('$days days left',
      name: 'game_list__days_left', args: [days]);

  String game_list__seconds_until(seconds) =>
      Intl.message('Starts in $seconds seconds',
          name: 'game_list__seconds_until', args: [seconds]);
  String game_list__minutes_until(minutes) =>
      Intl.message('Starts in $minutes minutes',
          name: 'game_list__minutes_until', args: [minutes]);
  String game_list__hours_until(hours) => Intl.message('Starts in $hours hours',
      name: 'game_list__hours_until', args: [hours]);
  String game_list__days_until(days) => Intl.message('Starts in $days days',
      name: 'game_list__days_until', args: [days]);

  /*
  ------------------------------ Components ----------------------------------
*/
  String get active_games_card__show_all_matches {
    return Intl.message('Show all matches',
        name: 'active_games_card__show_all_matches');
  }

  String get add_all_button_text {
    return Intl.message('+ Add all players ', name: 'add_all_button_text');
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

  String get games__start_new_match__solo_match {
    return Intl.message('Solo match',
        name: 'games__start_new_match__solo_match');
  }

  String get games__start_new_match__two_player_match {
    return Intl.message('Two player match',
        name: 'games__start_new_match__two_player_match');
  }

  String get games__start_new_match__group_match {
    return Intl.message('Group match',
        name: 'games__start_new_match__group_match');
  }

  String get games__your_matches {
    return Intl.message('Your matches', name: 'games__your_matches');
  }

  String get games__your_matches__solo_matches {
    return Intl.message('Solo matches',
        name: 'games__your_matches__solo_matches');
  }

  String get games__your_matches__two_player_matches {
    return Intl.message('Two player matches',
        name: 'games__your_matches__two_player_matches');
  }

  String get games__your_matches__group_matches {
    return Intl.message('Group matches',
        name: 'games__your_matches__group_matches');
  }

  String get games__your_matches__tournament_matches {
    return Intl.message('Tournaments',
        name: 'games__your_matches__tournament_matches');
  }

/*
  ------------------------------ Bottom navigation - Home ----------------------------------
*/

  String get home__title {
    return Intl.message('Home', name: 'home__title');
  }

  String get home__tournaments {
    return Intl.message('Tournaments', name: 'home__tournaments');
  }

  String get home__tournaments__upcomming {
    return Intl.message('Upcoming tournaments',
        name: 'home__tournaments__upcomming');
  }

  String get home__your_status {
    return Intl.message('Your status', name: 'home__your_status');
  }

  String get home__your_status__handicap {
    return Intl.message('Handicap', name: 'home__your_status__handicap');
  }

  String get home__your_status__bufferzone {
    return Intl.message('Bufferzone', name: 'home__your_status__bufferzone');
  }

  String get home__your_status__world_rank {
    return Intl.message('World rank', name: 'home__your_status__world_rank');
  }

  String get home__tip_of_the_day {
    return Intl.message('Tip of the day', name: 'home__tip_of_the_day');
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

  String get bottom_navigation__home {
    return Intl.message('Home', name: 'bottom_navigation__home');
  }

  String get bottom_navigation__games {
    return Intl.message('Games', name: 'bottom_navigation__games');
  }

  String get bottom_navigation__menu {
    return Intl.message('Menu', name: 'bottom_navigation__menu');
  }

/*
  ------------------------------ Game flow - Create match ----------------------------------
*/

  String get create_match__title__group_match {
    return Intl.message('Group match',
        name: 'create_match__title__group_match');
  }

  String get create_match__title__two_player_match {
    return Intl.message('Two player',
        name: 'create_match__title__two_player_match');
  }

  String get create_match__title__solo_match {
    return Intl.message('Solo', name: 'create_match__title__solo_match');
  }

  String get create_match__match_name {
    return Intl.message('Match name', name: 'create_match__match_name');
  }

  String get create_match__match_name__hint_text {
    return Intl.message('Match name',
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

  String get create_match__player_response_time {
    return Intl.message('Player response time',
        name: 'create_match__player_response_time');
  }

  String create_match__player_response_time__days(int days) =>
      Intl.message('${days} days',
          name: 'create_match__player_response_time__days', args: [days]);

  String get create_match__player_invite {
    return Intl.message('Invite players', name: 'create_match__player_invite');
  }

  String get create_match__player_invite__friends {
    return Intl.message('Friend', name: 'create_match__player_invite__friends');
  }

  String get create_match__player_invite__group {
    return Intl.message('Group', name: 'create_match__player_invite__group');
  }

  String get create_match__player_invite__club {
    return Intl.message('Club', name: 'create_match__player_invite__club');
  }

  String get create_match__start_button {
    return Intl.message('Start', name: 'create_match__start_button');
  }

  String get create_match__handicap {
    return Intl.message('Handicap', name: 'create_match__handicap');
  }

  String get create_match__handicap__switch_text {
    return Intl.message('Play with handicap',
        name: 'create_match__handicap__switch_text');
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

  String get game_flow__result__your_score {
    return Intl.message('Your score', name: 'game_flow__result__your_score');
  }

  String get game_flow__result__friends_ranking {
    return Intl.message('Friends Ranking',
        name: 'game_flow__result__friends_ranking');
  }

  String get game_flow__result__elaborate_rule {
    return Intl.message('Elaborate rule',
        name: 'game_flow__result__elaborate_rule');
  }

  String get game_flow__result__rule_overlay__title {
    return Intl.message('Rule elaboration',
        name: 'game_flow__result__rule_overlay__title');
  }

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

  String get game_flow__scoreboard__hole {
    return Intl.message('Hole', name: 'game_flow__scoreboard__hole');
  }

  String get game_flow__scoreboard__time {
    return Intl.message('Time', name: 'game_flow__scoreboard__time');
  }

  String get game_flow__scoreboard__points {
    return Intl.message('Points', name: 'game_flow__scoreboard__points');
  }

  String get game_flow__scoreboard__handicap {
    return Intl.message('Handicap', name: 'game_flow__scoreboard__handicap');
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

  String invite_helper__group__dialog_text(String players) => Intl.message(
      'This match already contains: \n$players \n\nPlease remove a player to add another.',
      name: 'invite_helper__group__dialog_text',
      args: [players]);

/*
  ------------------------------ Find players ----------------------------------
*/
  String get find_player__title {
    return Intl.message('Find player', name: 'find_player__title');
  }

  String get find_player__search_player {
    return Intl.message('Search for a player',
        name: 'find_player__search_player');
  }

  String get find_player__search_player_hint {
    return Intl.message('Search for a player',
        name: 'find_player__search_player_hint');
  }

  String find_player__add_popup__title(String name) =>
      Intl.message('Add $name?',
          name: 'find_player__add_popup__title', args: [name]);

  String find_player__add_popup__description(String name, String description) =>
      Intl.message('Do you want to add $name $description',
          name: 'find_player__add_popup__description',
          args: [name, description]);

  String get find_player__add_popup__to_friends {
    return Intl.message('to your friends?',
        name: 'find_player__add_popup__to_friends');
  }

  String get find_player__add_popup__to_group {
    return Intl.message('to the group?',
        name: 'find_player__add_popup__to_group');
  }

  String get find_player__add_popup__to_club {
    return Intl.message('to the club?',
        name: 'find_player__add_popup__to_club');
  }

  String get find_player__load_players {
    return Intl.message('Gathering players...',
        name: 'find_player__load_players');
  }

  /*
  ------------------------------ Profile ----------------------------------
*/
  String get edit_profile__title {
    return Intl.message('Edit profile', name: 'edit_profile__title');
  }

  String get edit_profile__old_password {
    return Intl.message('Old password', name: 'edit_profile__old_password');
  }

  String get edit_profile__new_password {
    return Intl.message('New password', name: 'edit_profile__new_password');
  }

  String get edit_profile__confirm_new_password {
    return Intl.message('Confirm new password',
        name: 'edit_profile__confirm_new_password');
  }

  String get edit_profile__save_loading {
    return Intl.message('Saving your profile...',
        name: 'edit_profile__save_loading');
  }

  String get profile__title {
    return Intl.message('My profile', name: 'profile__title');
  }

  String get profile__game_overview {
    return Intl.message('Game overview', name: 'profile__game_overview');
  }

  String get profile__game_overview__played {
    return Intl.message('Games played', name: 'profile__game_overview__played');
  }

  String get profile__game_overview__won {
    return Intl.message('Games won', name: 'profile__game_overview__won');
  }

  String get profile__game_overview__lost {
    return Intl.message('Games lost', name: 'profile__game_overview__lost');
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
      isSupported = locale.languageCode == 'en' || locale.languageCode == 'da';
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
