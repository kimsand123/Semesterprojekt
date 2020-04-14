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

  static m0(days) => "${days} days";

  static m1(seconds) => "${seconds}s";

  static m2(username) => "Do you want to remove ${username} from your friends?";

  static m3(username, deleteFrom) => "Do you want to remove ${username} from ${deleteFrom}?";

  static m4(group) => "Do you want to delete the group ${group}?";

  static m5(name, description) => "Do you want to add ${name} ${description}";

  static m6(name) => "Add ${name}?";

  static m7(gameProgress) => "Hole ${gameProgress}";

  static m8(ruleString) => "Rule ${ruleString}";

  static m9(end) => "Ended ${end}";

  static m10(days) => "${days} days left";

  static m11(days) => "Starts in ${days} days";

  static m12(currentHole, maxHoles) => "Hole ${currentHole} out of ${maxHoles}";

  static m13(hours) => "${hours} hours left";

  static m14(hours) => "Starts in ${hours} hours";

  static m15(minutes) => "${minutes} minutes left";

  static m16(minutes) => "Starts in ${minutes} minutes";

  static m17(amountOfPlayers) => "${amountOfPlayers} players";

  static m18(seconds) => "${seconds} seconds left";

  static m19(seconds) => "Starts in ${seconds} seconds";

  static m20(score) => "Total score of ${score}";

  static m21(players) => "This match already contains: \n${players} \n\nPlease remove a player to add another.";

  static m22(maxPlayersTwoPlayerMatch) => "Max ${maxPlayersTwoPlayerMatch} players reached";

  static m23(name) => "Two-player match can only contain two players. Remove ${name} to add a different player.";

  static m24(tooLong, length) => "${tooLong} should be under ${length} letters";

  static m25(tooShort, length) => "${tooShort} should be at least ${length} letters";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Their turn" : MessageLookupByLibrary.simpleMessage("Their turn"),
    "Your turn" : MessageLookupByLibrary.simpleMessage("Your turn"),
    "about__about_app" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    "about__about_app_title" : MessageLookupByLibrary.simpleMessage("About this app"),
    "about__copyrights" : MessageLookupByLibrary.simpleMessage("Excerpts from The Rules of Golf and interpretations are reprinted with permission. \n\nCopyright © (2019) R&A Rules Limited. All rights reserved. All rules questions Copyright © (2019) GolfQuiz / Appicorn ApS. All rights reserved"),
    "about__copyrights_title" : MessageLookupByLibrary.simpleMessage("Copyrights"),
    "about__policies_privacy_button" : MessageLookupByLibrary.simpleMessage("Privacy policy"),
    "about__policies_terms_button" : MessageLookupByLibrary.simpleMessage("Terms & Conditions"),
    "about__policies_title" : MessageLookupByLibrary.simpleMessage("Policies"),
    "about__title" : MessageLookupByLibrary.simpleMessage("About"),
    "active_games_card__show_all_matches" : MessageLookupByLibrary.simpleMessage("Show all matches"),
    "add__group_members" : MessageLookupByLibrary.simpleMessage("+ Add group members"),
    "add_all_button_text" : MessageLookupByLibrary.simpleMessage("+ Add all players "),
    "admin" : MessageLookupByLibrary.simpleMessage("Admin"),
    "app_settings__audio" : MessageLookupByLibrary.simpleMessage("Audio"),
    "app_settings__audio_title" : MessageLookupByLibrary.simpleMessage("Audio settings"),
    "app_settings__language_hint" : MessageLookupByLibrary.simpleMessage("Language"),
    "app_settings__language_title" : MessageLookupByLibrary.simpleMessage("Select language"),
    "app_settings__notifications" : MessageLookupByLibrary.simpleMessage("Notifications"),
    "app_settings__notifications_title" : MessageLookupByLibrary.simpleMessage("Notifications settings"),
    "app_settings__privacy_club" : MessageLookupByLibrary.simpleMessage("Connect profile to club"),
    "app_settings__privacy_ranking" : MessageLookupByLibrary.simpleMessage("Visible on ranking boards"),
    "app_settings__privacy_title" : MessageLookupByLibrary.simpleMessage("Privacy settings"),
    "app_settings__title" : MessageLookupByLibrary.simpleMessage("App settings"),
    "appbar__edit_button" : MessageLookupByLibrary.simpleMessage("Edit"),
    "auth__email_caption" : MessageLookupByLibrary.simpleMessage("Email"),
    "auth__password_caption" : MessageLookupByLibrary.simpleMessage("Password"),
    "auth__signup_button" : MessageLookupByLibrary.simpleMessage("Signup"),
    "auth__terms_button" : MessageLookupByLibrary.simpleMessage("Terms and conditions"),
    "auth_forgot_password__email_caption" : MessageLookupByLibrary.simpleMessage("Enter your email adress"),
    "auth_forgot_password__progress_text" : MessageLookupByLibrary.simpleMessage("Sending a password your way..."),
    "auth_forgot_password__reset_password_button" : MessageLookupByLibrary.simpleMessage("Reset password"),
    "auth_forgot_password__title" : MessageLookupByLibrary.simpleMessage("Forgot password"),
    "auth_intro__login_button" : MessageLookupByLibrary.simpleMessage("Login"),
    "auth_login__join_button" : MessageLookupByLibrary.simpleMessage("Don\'t you have an account? Join us here"),
    "auth_login__login_button" : MessageLookupByLibrary.simpleMessage("Login"),
    "auth_login__progress_text" : MessageLookupByLibrary.simpleMessage("Signing you in..."),
    "auth_login__reset_password_button" : MessageLookupByLibrary.simpleMessage("Reset password"),
    "auth_login__title" : MessageLookupByLibrary.simpleMessage("Login"),
    "auth_signup__confirm_password_caption" : MessageLookupByLibrary.simpleMessage("Confirm password"),
    "auth_signup__country_caption" : MessageLookupByLibrary.simpleMessage("Country"),
    "auth_signup__country_hint" : MessageLookupByLibrary.simpleMessage("Denmark"),
    "auth_signup__dgu_number_caption" : MessageLookupByLibrary.simpleMessage("Club number"),
    "auth_signup__dgu_number_hint" : MessageLookupByLibrary.simpleMessage("00-000"),
    "auth_signup__progress_text" : MessageLookupByLibrary.simpleMessage("Signing you up..."),
    "auth_signup__title" : MessageLookupByLibrary.simpleMessage("Getting Started"),
    "auth_signup__username_caption" : MessageLookupByLibrary.simpleMessage("Username"),
    "auth_signup__username_hint" : MessageLookupByLibrary.simpleMessage("Name"),
    "bottom_navigation__games" : MessageLookupByLibrary.simpleMessage("Games"),
    "bottom_navigation__home" : MessageLookupByLibrary.simpleMessage("Home"),
    "bottom_navigation__menu" : MessageLookupByLibrary.simpleMessage("Menu"),
    "bufferzone" : MessageLookupByLibrary.simpleMessage("Bufferzone"),
    "club__add_club_members_button" : MessageLookupByLibrary.simpleMessage("+ Add new club member"),
    "club__group_list__first_title" : MessageLookupByLibrary.simpleMessage("Club member"),
    "club__group_list__second_title" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "club__title" : MessageLookupByLibrary.simpleMessage("Club"),
    "club_number" : MessageLookupByLibrary.simpleMessage("Club Number"),
    "country" : MessageLookupByLibrary.simpleMessage("Country"),
    "create_match__handicap" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "create_match__handicap__switch_text" : MessageLookupByLibrary.simpleMessage("Play with handicap"),
    "create_match__match_name" : MessageLookupByLibrary.simpleMessage("Match name"),
    "create_match__match_name__hint_text" : MessageLookupByLibrary.simpleMessage("Match name"),
    "create_match__player_invite" : MessageLookupByLibrary.simpleMessage("Invite players"),
    "create_match__player_invite__club" : MessageLookupByLibrary.simpleMessage("Club"),
    "create_match__player_invite__friends" : MessageLookupByLibrary.simpleMessage("Friend"),
    "create_match__player_invite__group" : MessageLookupByLibrary.simpleMessage("Group"),
    "create_match__player_response_time" : MessageLookupByLibrary.simpleMessage("Player response time"),
    "create_match__player_response_time__days" : m0,
    "create_match__question_duration" : MessageLookupByLibrary.simpleMessage("Question duration"),
    "create_match__question_duration__custom" : MessageLookupByLibrary.simpleMessage("Custom duration"),
    "create_match__question_duration__seconds" : m1,
    "create_match__start_button" : MessageLookupByLibrary.simpleMessage("Start"),
    "create_match__title__group_match" : MessageLookupByLibrary.simpleMessage("Group match"),
    "create_match__title__solo_match" : MessageLookupByLibrary.simpleMessage("Solo"),
    "create_match__title__two_player_match" : MessageLookupByLibrary.simpleMessage("Two player"),
    "danish" : MessageLookupByLibrary.simpleMessage("Danish"),
    "days" : MessageLookupByLibrary.simpleMessage("Days"),
    "dialog__are_you_sure" : MessageLookupByLibrary.simpleMessage("Are you sure?"),
    "dialog__delete" : m2,
    "dialog__delete_from" : m3,
    "dialog__delete_group" : m4,
    "edit_profile__confirm_new_password" : MessageLookupByLibrary.simpleMessage("Confirm new password"),
    "edit_profile__new_password" : MessageLookupByLibrary.simpleMessage("New password"),
    "edit_profile__old_password" : MessageLookupByLibrary.simpleMessage("Old password"),
    "edit_profile__save_loading" : MessageLookupByLibrary.simpleMessage("Saving your profile..."),
    "edit_profile__title" : MessageLookupByLibrary.simpleMessage("Edit profile"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "english" : MessageLookupByLibrary.simpleMessage("English"),
    "error__data_was_not_recieved" : MessageLookupByLibrary.simpleMessage("An error has occured! \nPlease contact our support team if this error keeps occuring. "),
    "exit" : MessageLookupByLibrary.simpleMessage("Exit"),
    "find_player__add_popup__description" : m5,
    "find_player__add_popup__title" : m6,
    "find_player__add_popup__to_club" : MessageLookupByLibrary.simpleMessage("to the club?"),
    "find_player__add_popup__to_friends" : MessageLookupByLibrary.simpleMessage("to your friends?"),
    "find_player__add_popup__to_group" : MessageLookupByLibrary.simpleMessage("to the group?"),
    "find_player__load_players" : MessageLookupByLibrary.simpleMessage("Gathering players..."),
    "find_player__search_player" : MessageLookupByLibrary.simpleMessage("Search for a player"),
    "find_player__search_player_hint" : MessageLookupByLibrary.simpleMessage("Search for a player"),
    "find_player__title" : MessageLookupByLibrary.simpleMessage("Find player"),
    "friends__add_friends_button" : MessageLookupByLibrary.simpleMessage("+ Add new friends"),
    "friends__list_first_title" : MessageLookupByLibrary.simpleMessage("Player"),
    "friends__list_second_title" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "friends__notification" : MessageLookupByLibrary.simpleMessage("New friend request"),
    "friends__title" : MessageLookupByLibrary.simpleMessage("Friends"),
    "game_appbar__players" : MessageLookupByLibrary.simpleMessage("Players"),
    "game_appbar__question_duration" : MessageLookupByLibrary.simpleMessage("Q. duration"),
    "game_appbar__your_score" : MessageLookupByLibrary.simpleMessage("Your score"),
    "game_flow__days_short" : MessageLookupByLibrary.simpleMessage("Days"),
    "game_flow__elaborate_rule__title" : MessageLookupByLibrary.simpleMessage("Elaborate rule"),
    "game_flow__hours_short" : MessageLookupByLibrary.simpleMessage("Hours"),
    "game_flow__minutes_short" : MessageLookupByLibrary.simpleMessage("Min."),
    "game_flow__question__q_duration" : MessageLookupByLibrary.simpleMessage("Q. duration"),
    "game_flow__question__title" : MessageLookupByLibrary.simpleMessage("GolfQuiz"),
    "game_flow__question__your_score" : MessageLookupByLibrary.simpleMessage("Your score"),
    "game_flow__result__continue" : MessageLookupByLibrary.simpleMessage("Continue"),
    "game_flow__result__correct" : MessageLookupByLibrary.simpleMessage("Correct"),
    "game_flow__result__elaborate_rule" : MessageLookupByLibrary.simpleMessage("Elaborate rule"),
    "game_flow__result__friends_ranking" : MessageLookupByLibrary.simpleMessage("Friends Ranking"),
    "game_flow__result__hole" : m7,
    "game_flow__result__pause_dialog" : MessageLookupByLibrary.simpleMessage("Are you sure you want to pause the game?"),
    "game_flow__result__rule" : m8,
    "game_flow__result__rule_overlay__title" : MessageLookupByLibrary.simpleMessage("Rule elaboration"),
    "game_flow__result__scoreboard" : MessageLookupByLibrary.simpleMessage("Scoreboard"),
    "game_flow__result__wrong" : MessageLookupByLibrary.simpleMessage("Wrong"),
    "game_flow__result__your_score" : MessageLookupByLibrary.simpleMessage("Your score"),
    "game_flow__scoreboard__end_game" : MessageLookupByLibrary.simpleMessage("End game"),
    "game_flow__scoreboard__handicap" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "game_flow__scoreboard__hole" : MessageLookupByLibrary.simpleMessage("Hole"),
    "game_flow__scoreboard__pause_dialog" : MessageLookupByLibrary.simpleMessage("Are you sure you want to pause the game?"),
    "game_flow__scoreboard__player" : MessageLookupByLibrary.simpleMessage("Player"),
    "game_flow__scoreboard__points" : MessageLookupByLibrary.simpleMessage("Points"),
    "game_flow__scoreboard__q_duration" : MessageLookupByLibrary.simpleMessage("Q. duration"),
    "game_flow__scoreboard__resume" : MessageLookupByLibrary.simpleMessage("Resume"),
    "game_flow__scoreboard__time" : MessageLookupByLibrary.simpleMessage("Time"),
    "game_flow__scoreboard__your_score" : MessageLookupByLibrary.simpleMessage("Your score"),
    "game_flow__seconds_short" : MessageLookupByLibrary.simpleMessage("Sec."),
    "game_list__active_matches" : MessageLookupByLibrary.simpleMessage("Active matches"),
    "game_list__date_ended_at" : m9,
    "game_list__days_left" : m10,
    "game_list__days_until" : m11,
    "game_list__group_matches" : MessageLookupByLibrary.simpleMessage("Group matches"),
    "game_list__hole_out_of" : m12,
    "game_list__hours_left" : m13,
    "game_list__hours_until" : m14,
    "game_list__inactive_matches" : MessageLookupByLibrary.simpleMessage("Previous matches"),
    "game_list__minutes_left" : m15,
    "game_list__minutes_until" : m16,
    "game_list__num_of_players" : m17,
    "game_list__seconds_left" : m18,
    "game_list__seconds_until" : m19,
    "game_list__solo_matches" : MessageLookupByLibrary.simpleMessage("Solo matches"),
    "game_list__total_score" : m20,
    "game_list__tournaments_matches" : MessageLookupByLibrary.simpleMessage("Tournament matches"),
    "game_list__two_player_matches" : MessageLookupByLibrary.simpleMessage("Two player matches"),
    "game_tournaments__are_you_sure" : MessageLookupByLibrary.simpleMessage("Are you sure you want to join this tournament?"),
    "game_tournaments__join_tournaments" : MessageLookupByLibrary.simpleMessage("Join tournament"),
    "game_tournaments__no_tournaments" : MessageLookupByLibrary.simpleMessage("There are no upcoming or ongoing tournaments.."),
    "game_tournaments__ongoing_tournaments" : MessageLookupByLibrary.simpleMessage("Ongoing Tournaments"),
    "game_tournaments__start" : MessageLookupByLibrary.simpleMessage("Starts"),
    "game_tournaments__upcoming_tournaments" : MessageLookupByLibrary.simpleMessage("Upcoming Tournaments"),
    "games__start_new_match" : MessageLookupByLibrary.simpleMessage("Start new match"),
    "games__start_new_match__group_match" : MessageLookupByLibrary.simpleMessage("Group match"),
    "games__start_new_match__solo_match" : MessageLookupByLibrary.simpleMessage("Solo match"),
    "games__start_new_match__two_player_match" : MessageLookupByLibrary.simpleMessage("Two player match"),
    "games__title" : MessageLookupByLibrary.simpleMessage("Games"),
    "games__your_matches" : MessageLookupByLibrary.simpleMessage("Your matches"),
    "games__your_matches__group_matches" : MessageLookupByLibrary.simpleMessage("Group matches"),
    "games__your_matches__solo_matches" : MessageLookupByLibrary.simpleMessage("Solo matches"),
    "games__your_matches__tournament_matches" : MessageLookupByLibrary.simpleMessage("Tournaments"),
    "games__your_matches__two_player_matches" : MessageLookupByLibrary.simpleMessage("Two player matches"),
    "groups__create_group_title" : MessageLookupByLibrary.simpleMessage("Create group"),
    "groups__create_new_group" : MessageLookupByLibrary.simpleMessage("+ Create new group"),
    "groups__delete_group" : MessageLookupByLibrary.simpleMessage("Delete the group"),
    "groups__group_list__first_title" : MessageLookupByLibrary.simpleMessage("Group name"),
    "groups__group_list__second_title" : MessageLookupByLibrary.simpleMessage("Avg. handicap"),
    "groups__notification" : MessageLookupByLibrary.simpleMessage("New group invite"),
    "groups__saving_group_popup" : MessageLookupByLibrary.simpleMessage("Saving the group..."),
    "groups__single_group_list__first_title" : MessageLookupByLibrary.simpleMessage("Player"),
    "groups__single_group_list__second_title" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "groups__title" : MessageLookupByLibrary.simpleMessage("Groups"),
    "handicap" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "help_and_feedback__contact" : MessageLookupByLibrary.simpleMessage("greenkeeper@golfquis.com"),
    "help_and_feedback__contact_title" : MessageLookupByLibrary.simpleMessage("Contact us"),
    "help_and_feedback__handicap_rules" : MessageLookupByLibrary.simpleMessage("Handicap rule description"),
    "help_and_feedback__handicap_rules_title" : MessageLookupByLibrary.simpleMessage("Golf Rule Handicap"),
    "help_and_feedback__how_to_play" : MessageLookupByLibrary.simpleMessage("Guide"),
    "help_and_feedback__how_to_play_title" : MessageLookupByLibrary.simpleMessage("How to play"),
    "help_and_feedback__title" : MessageLookupByLibrary.simpleMessage("Help & Feedback"),
    "hole" : MessageLookupByLibrary.simpleMessage("Hole"),
    "home__tip_of_the_day" : MessageLookupByLibrary.simpleMessage("Tip of the day"),
    "home__title" : MessageLookupByLibrary.simpleMessage("Home"),
    "home__tournaments" : MessageLookupByLibrary.simpleMessage("Tournaments"),
    "home__tournaments__upcomming" : MessageLookupByLibrary.simpleMessage("Upcoming tournaments"),
    "home__your_status" : MessageLookupByLibrary.simpleMessage("Your status"),
    "home__your_status__bufferzone" : MessageLookupByLibrary.simpleMessage("Bufferzone"),
    "home__your_status__handicap" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "home__your_status__world_rank" : MessageLookupByLibrary.simpleMessage("World rank"),
    "hours" : MessageLookupByLibrary.simpleMessage("Hours"),
    "invite_helper__group__dialog_text" : m21,
    "invite_helper__max_players" : m22,
    "invite_helper__two_player__dialog_text" : m23,
    "menu__about_button" : MessageLookupByLibrary.simpleMessage("About"),
    "menu__app_settings_button" : MessageLookupByLibrary.simpleMessage("App settings"),
    "menu__club_button" : MessageLookupByLibrary.simpleMessage("Club"),
    "menu__email_error" : MessageLookupByLibrary.simpleMessage("No email found?"),
    "menu__friends_button" : MessageLookupByLibrary.simpleMessage("Friends"),
    "menu__group_button" : MessageLookupByLibrary.simpleMessage("Groups"),
    "menu__help_and_feedback_button" : MessageLookupByLibrary.simpleMessage("Help and feedback"),
    "menu__log_out_button" : MessageLookupByLibrary.simpleMessage("Log out"),
    "menu__profile_button" : MessageLookupByLibrary.simpleMessage("Profile"),
    "menu__settings_section" : MessageLookupByLibrary.simpleMessage("Settings"),
    "menu__status_button" : MessageLookupByLibrary.simpleMessage("Status"),
    "menu__title" : MessageLookupByLibrary.simpleMessage("Menu"),
    "mins" : MessageLookupByLibrary.simpleMessage("Min"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "player" : MessageLookupByLibrary.simpleMessage("Player"),
    "points" : MessageLookupByLibrary.simpleMessage("Points"),
    "privacy_policy__title" : MessageLookupByLibrary.simpleMessage("Privacy policy"),
    "profile__game_overview" : MessageLookupByLibrary.simpleMessage("Game overview"),
    "profile__game_overview__lost" : MessageLookupByLibrary.simpleMessage("Games lost"),
    "profile__game_overview__played" : MessageLookupByLibrary.simpleMessage("Games played"),
    "profile__game_overview__won" : MessageLookupByLibrary.simpleMessage("Games won"),
    "profile__title" : MessageLookupByLibrary.simpleMessage("My profile"),
    "progressbar_text" : MessageLookupByLibrary.simpleMessage("Your progress"),
    "rank" : MessageLookupByLibrary.simpleMessage("Rank"),
    "resume" : MessageLookupByLibrary.simpleMessage("Resume"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "secs" : MessageLookupByLibrary.simpleMessage("Sec"),
    "status" : MessageLookupByLibrary.simpleMessage("Status"),
    "status__game_overview_title" : MessageLookupByLibrary.simpleMessage("Game overview"),
    "status__games_lost" : MessageLookupByLibrary.simpleMessage("Games lost"),
    "status__games_played" : MessageLookupByLibrary.simpleMessage("Games played"),
    "status__games_won" : MessageLookupByLibrary.simpleMessage("Games won"),
    "status__ranking_club_button" : MessageLookupByLibrary.simpleMessage("Club rank"),
    "status__ranking_club_overlay" : MessageLookupByLibrary.simpleMessage("Club ranking"),
    "status__ranking_friends_button" : MessageLookupByLibrary.simpleMessage("Friends rank"),
    "status__ranking_friends_overlay" : MessageLookupByLibrary.simpleMessage("Friends ranking"),
    "status__ranking_title" : MessageLookupByLibrary.simpleMessage("Ranking"),
    "status__ranking_world_overlay" : MessageLookupByLibrary.simpleMessage("World ranking"),
    "status__title" : MessageLookupByLibrary.simpleMessage("Status"),
    "terms_conditions__title" : MessageLookupByLibrary.simpleMessage("Terms & Conditions"),
    "time" : MessageLookupByLibrary.simpleMessage("Time"),
    "validation__dgu_number" : MessageLookupByLibrary.simpleMessage("DGU number should be 5 numbers"),
    "validation__enter_name" : MessageLookupByLibrary.simpleMessage("Enter a name to search"),
    "validation__enter_valid_email" : MessageLookupByLibrary.simpleMessage("Enter valid email"),
    "validation__password_not_the_same" : MessageLookupByLibrary.simpleMessage("Password must be the same"),
    "validation__reenter_password" : MessageLookupByLibrary.simpleMessage("Please re-enter the password"),
    "validation__too_long" : m24,
    "validation__too_short" : m25,
    "validation__too_short_password" : MessageLookupByLibrary.simpleMessage("Password must be more than 6 characters"),
    "world_rank" : MessageLookupByLibrary.simpleMessage("World rank"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes"),
    "you" : MessageLookupByLibrary.simpleMessage("You")
  };
}
