// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(seconds) => "${seconds}s";

  static m1(gameProgress) => "Hole ${gameProgress}";

  static m2(ruleString) => "Rule ${ruleString}";

  static m3(maxPlayersTwoPlayerMatch) => "Max ${maxPlayersTwoPlayerMatch} players reached";

  static m4(name) => "Two-player match can only contain two players. Remove ${name} to add a different player.";

  static m5(tooLong, length) => "${tooLong} should be under ${length} letters";

  static m6(tooShort, length) => "${tooShort} should be at least ${length} letters";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "active_games_card__show_all_matches" : MessageLookupByLibrary.simpleMessage("Show all matches"),
    "auth__password_caption" : MessageLookupByLibrary.simpleMessage("Password"),
    "auth__username_caption" : MessageLookupByLibrary.simpleMessage("Username"),
    "auth_intro__login_button" : MessageLookupByLibrary.simpleMessage("Login"),
    "auth_login__login_button" : MessageLookupByLibrary.simpleMessage("Login"),
    "auth_login__progress_text" : MessageLookupByLibrary.simpleMessage("Signing you in..."),
    "auth_login__reset_password_button" : MessageLookupByLibrary.simpleMessage("Reset password"),
    "auth_login__title" : MessageLookupByLibrary.simpleMessage("Login"),
    "bottom_navigation__games" : MessageLookupByLibrary.simpleMessage("Games"),
    "bottom_navigation__menu" : MessageLookupByLibrary.simpleMessage("Menu"),
    "create_match__match_name" : MessageLookupByLibrary.simpleMessage("Match name"),
    "create_match__match_name__hint_text" : MessageLookupByLibrary.simpleMessage("ex. Super match"),
    "create_match__player_invite" : MessageLookupByLibrary.simpleMessage("Invite players"),
    "create_match__player_invite__friends" : MessageLookupByLibrary.simpleMessage("Friend"),
    "create_match__question_duration" : MessageLookupByLibrary.simpleMessage("Question duration"),
    "create_match__question_duration__custom" : MessageLookupByLibrary.simpleMessage("Custom duration"),
    "create_match__question_duration__seconds" : m0,
    "create_match__title__two_player_match" : MessageLookupByLibrary.simpleMessage("Two player"),
    "days" : MessageLookupByLibrary.simpleMessage("Days"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "error__data_was_not_recieved" : MessageLookupByLibrary.simpleMessage("An error has occured! \nPlease contact our support team if this error keeps occuring. "),
    "exit" : MessageLookupByLibrary.simpleMessage("Exit"),
    "friends__list_first_title" : MessageLookupByLibrary.simpleMessage("Player"),
    "friends__title" : MessageLookupByLibrary.simpleMessage("Friends"),
    "game_appbar__question_duration" : MessageLookupByLibrary.simpleMessage("Q. duration"),
    "game_appbar__your_score" : MessageLookupByLibrary.simpleMessage("Your score"),
    "game_flow__days_short" : MessageLookupByLibrary.simpleMessage("Days"),
    "game_flow__hours_short" : MessageLookupByLibrary.simpleMessage("Hours"),
    "game_flow__minutes_short" : MessageLookupByLibrary.simpleMessage("Min."),
    "game_flow__question__q_duration" : MessageLookupByLibrary.simpleMessage("Q. duration"),
    "game_flow__question__title" : MessageLookupByLibrary.simpleMessage("GolfQuiz"),
    "game_flow__question__your_score" : MessageLookupByLibrary.simpleMessage("Your score"),
    "game_flow__result__continue" : MessageLookupByLibrary.simpleMessage("Continue"),
    "game_flow__result__correct" : MessageLookupByLibrary.simpleMessage("Correct"),
    "game_flow__result__hole" : m1,
    "game_flow__result__pause_dialog" : MessageLookupByLibrary.simpleMessage("Are you sure you want to pause the game?"),
    "game_flow__result__rule" : m2,
    "game_flow__result__scoreboard" : MessageLookupByLibrary.simpleMessage("Scoreboard"),
    "game_flow__result__wrong" : MessageLookupByLibrary.simpleMessage("Wrong"),
    "game_flow__scoreboard__end_game" : MessageLookupByLibrary.simpleMessage("End game"),
    "game_flow__scoreboard__pause_dialog" : MessageLookupByLibrary.simpleMessage("Are you sure you want to pause the game?"),
    "game_flow__scoreboard__player" : MessageLookupByLibrary.simpleMessage("Player"),
    "game_flow__scoreboard__points" : MessageLookupByLibrary.simpleMessage("Points"),
    "game_flow__scoreboard__q_duration" : MessageLookupByLibrary.simpleMessage("Q. duration"),
    "game_flow__scoreboard__resume" : MessageLookupByLibrary.simpleMessage("Resume"),
    "game_flow__scoreboard__your_score" : MessageLookupByLibrary.simpleMessage("Your score"),
    "game_flow__seconds_short" : MessageLookupByLibrary.simpleMessage("Sec."),
    "game_list__active_matches" : MessageLookupByLibrary.simpleMessage("Active matches"),
    "game_list__inactive_matches" : MessageLookupByLibrary.simpleMessage("Previous matches"),
    "game_list__two_player_matches" : MessageLookupByLibrary.simpleMessage("Two player matches"),
    "games__start_new_match" : MessageLookupByLibrary.simpleMessage("Start new match"),
    "games__start_new_match__two_player_match" : MessageLookupByLibrary.simpleMessage("Two player match"),
    "games__title" : MessageLookupByLibrary.simpleMessage("Games"),
    "games__your_matches" : MessageLookupByLibrary.simpleMessage("Your matches"),
    "games__your_matches__two_player_matches" : MessageLookupByLibrary.simpleMessage("Two player matches"),
    "groups__group_list__first_title" : MessageLookupByLibrary.simpleMessage("Group name"),
    "groups__group_list__second_title" : MessageLookupByLibrary.simpleMessage("Avg. handicap"),
    "handicap" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "hole" : MessageLookupByLibrary.simpleMessage("Hole"),
    "hours" : MessageLookupByLibrary.simpleMessage("Hours"),
    "invite_helper__max_players" : m3,
    "invite_helper__two_player__dialog_text" : m4,
    "menu__email_error" : MessageLookupByLibrary.simpleMessage("No email found?"),
    "menu__friends_button" : MessageLookupByLibrary.simpleMessage("Friends"),
    "menu__log_out_button" : MessageLookupByLibrary.simpleMessage("Log out"),
    "menu__profile_button" : MessageLookupByLibrary.simpleMessage("Profile"),
    "menu__title" : MessageLookupByLibrary.simpleMessage("Menu"),
    "mins" : MessageLookupByLibrary.simpleMessage("Min"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "player" : MessageLookupByLibrary.simpleMessage("Player"),
    "points" : MessageLookupByLibrary.simpleMessage("Points"),
    "profile__title" : MessageLookupByLibrary.simpleMessage("My profile"),
    "progressbar_text" : MessageLookupByLibrary.simpleMessage("Your progress"),
    "resume" : MessageLookupByLibrary.simpleMessage("Resume"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "secs" : MessageLookupByLibrary.simpleMessage("Sec"),
    "status" : MessageLookupByLibrary.simpleMessage("Status"),
    "validation__enter_valid_username" : MessageLookupByLibrary.simpleMessage("Enter valid username - ex. \'s123456\'"),
    "validation__too_long" : m5,
    "validation__too_short" : m6,
    "validation__too_short_password" : MessageLookupByLibrary.simpleMessage("Password must be more than 6 characters"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes"),
    "you" : MessageLookupByLibrary.simpleMessage("You")
  };
}
