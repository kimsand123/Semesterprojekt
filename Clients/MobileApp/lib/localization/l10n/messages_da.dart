// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a da locale. All the
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
  String get localeName => 'da';

  static m0(days) => "${days} dage";

  static m1(seconds) => "${seconds}s";

  static m2(username) => "Er du sikker på du vil fjerne ${username} fra dine venner?";

  static m3(username, deleteFrom) => "Er du sikker på du vil fjerne ${username} fra ${deleteFrom}?";

  static m4(group) => "Vil du slette gruppen ${group}?";

  static m5(name, description) => "Vil du tilføje ${name} ${description}";

  static m6(name) => "Tilføj ${name}?";

  static m7(gameProgress) => "Hul ${gameProgress}";

  static m8(ruleString) => "Regel ${ruleString}";

  static m9(end) => "Sluttede ${end}";

  static m10(days) => "${days} dage tilbage";

  static m11(days) => "Starter om ${days} dage";

  static m12(currentHole, maxHoles) => "Hul ${currentHole} ud af ${maxHoles}";

  static m13(hours) => "${hours} timer tilbage";

  static m14(hours) => "Starter om ${hours} timer";

  static m15(minutes) => "${minutes} minutter tilbage";

  static m16(minutes) => "Starter om ${minutes} minutter";

  static m17(amountOfPlayers) => "${amountOfPlayers} spillere";

  static m18(seconds) => "${seconds} sekunder tilbage";

  static m19(seconds) => "Start om ${seconds} sekunder";

  static m20(score) => "Samlet score på ${score}";

  static m21(players) => "Denne match indeholder allerede: \n${players} \n\nVenligst fjern en spiller, for at tilføje en ny.";

  static m22(maxPlayersTwoPlayerMatch) => "Max ${maxPlayersTwoPlayerMatch} spillere";

  static m23(name) => "To spiller match kan kun indeholde to spillere. Fjern ${name} for at tilføje en anden spiller.";

  static m24(tooLong, length) => "${tooLong} bør være under ${length} bogstaver";

  static m25(tooShort, length) => "${tooShort} bør være mindst ${length} bogstaver";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Their turn" : MessageLookupByLibrary.simpleMessage("Deres tur"),
    "Your turn" : MessageLookupByLibrary.simpleMessage("Din tur"),
    "about__about_app" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    "about__about_app_title" : MessageLookupByLibrary.simpleMessage("Om denne app"),
    "about__copyrights" : MessageLookupByLibrary.simpleMessage("Excerpts from The Rules of Golf and interpretations are reprinted with permission. \n\nCopyright © (2019) R&A Rules Limited. All rights reserved. All rules questions Copyright © (2019) GolfQuiz / Appicorn ApS. All rights reserved"),
    "about__copyrights_title" : MessageLookupByLibrary.simpleMessage("Ophavsret"),
    "about__policies_privacy_button" : MessageLookupByLibrary.simpleMessage("Privat politik"),
    "about__policies_terms_button" : MessageLookupByLibrary.simpleMessage("Vilkår og betingelser"),
    "about__policies_title" : MessageLookupByLibrary.simpleMessage("Politikker"),
    "about__title" : MessageLookupByLibrary.simpleMessage("Om appen"),
    "active_games_card__show_all_matches" : MessageLookupByLibrary.simpleMessage("Vis alle matcher"),
    "add__group_members" : MessageLookupByLibrary.simpleMessage("+ Tilføj gruppemedlemmer"),
    "add_all_button_text" : MessageLookupByLibrary.simpleMessage("+ Tilføj alle spillere"),
    "admin" : MessageLookupByLibrary.simpleMessage("Bestyrer"),
    "app_settings__audio" : MessageLookupByLibrary.simpleMessage("Lyd"),
    "app_settings__audio_title" : MessageLookupByLibrary.simpleMessage("Lyd indstillinger"),
    "app_settings__language_hint" : MessageLookupByLibrary.simpleMessage("Sprog"),
    "app_settings__language_title" : MessageLookupByLibrary.simpleMessage("Vælg sprog"),
    "app_settings__notifications" : MessageLookupByLibrary.simpleMessage("Notifikationer"),
    "app_settings__notifications_title" : MessageLookupByLibrary.simpleMessage("Notifikationsindstillinger"),
    "app_settings__privacy_club" : MessageLookupByLibrary.simpleMessage("Forbind profil til klub"),
    "app_settings__privacy_ranking" : MessageLookupByLibrary.simpleMessage("Synlig på ranglister"),
    "app_settings__privacy_title" : MessageLookupByLibrary.simpleMessage("Privat indstillinger"),
    "app_settings__title" : MessageLookupByLibrary.simpleMessage("App indstillinger"),
    "appbar__edit_button" : MessageLookupByLibrary.simpleMessage("Rediger"),
    "auth__email_caption" : MessageLookupByLibrary.simpleMessage("Email"),
    "auth__password_caption" : MessageLookupByLibrary.simpleMessage("Adgangskode"),
    "auth__signup_button" : MessageLookupByLibrary.simpleMessage("Ny spiller"),
    "auth__terms_button" : MessageLookupByLibrary.simpleMessage("Vilkår og betingelser"),
    "auth_forgot_password__email_caption" : MessageLookupByLibrary.simpleMessage("Skriv din email adresse"),
    "auth_forgot_password__progress_text" : MessageLookupByLibrary.simpleMessage("Sender en adgangskode din vej..."),
    "auth_forgot_password__reset_password_button" : MessageLookupByLibrary.simpleMessage("Nulstil adgangskode"),
    "auth_forgot_password__title" : MessageLookupByLibrary.simpleMessage("Glemt adgangskode"),
    "auth_intro__login_button" : MessageLookupByLibrary.simpleMessage("Log ind"),
    "auth_login__join_button" : MessageLookupByLibrary.simpleMessage("Har du ikke en konto? Opret dig her"),
    "auth_login__login_button" : MessageLookupByLibrary.simpleMessage("Log ind"),
    "auth_login__progress_text" : MessageLookupByLibrary.simpleMessage("Logger dig ind..."),
    "auth_login__reset_password_button" : MessageLookupByLibrary.simpleMessage("Nulstil adgangskode"),
    "auth_login__title" : MessageLookupByLibrary.simpleMessage("Log ind"),
    "auth_signup__confirm_password_caption" : MessageLookupByLibrary.simpleMessage("Bekræft adgangskode"),
    "auth_signup__country_caption" : MessageLookupByLibrary.simpleMessage("Land"),
    "auth_signup__country_hint" : MessageLookupByLibrary.simpleMessage("Danmark"),
    "auth_signup__dgu_number_caption" : MessageLookupByLibrary.simpleMessage("Klubnummer"),
    "auth_signup__dgu_number_hint" : MessageLookupByLibrary.simpleMessage("00-000"),
    "auth_signup__progress_text" : MessageLookupByLibrary.simpleMessage("Opretter dig..."),
    "auth_signup__title" : MessageLookupByLibrary.simpleMessage("Kom igang"),
    "auth_signup__username_caption" : MessageLookupByLibrary.simpleMessage("Brugernavn"),
    "auth_signup__username_hint" : MessageLookupByLibrary.simpleMessage("Navn"),
    "bottom_navigation__games" : MessageLookupByLibrary.simpleMessage("Spil"),
    "bottom_navigation__home" : MessageLookupByLibrary.simpleMessage("Hjem"),
    "bottom_navigation__menu" : MessageLookupByLibrary.simpleMessage("Menu"),
    "bufferzone" : MessageLookupByLibrary.simpleMessage("Bufferzone"),
    "club__add_club_members_button" : MessageLookupByLibrary.simpleMessage("+ Tilføj nyt klubmedlem"),
    "club__group_list__first_title" : MessageLookupByLibrary.simpleMessage("Klubmedlem"),
    "club__group_list__second_title" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "club__title" : MessageLookupByLibrary.simpleMessage("Klub"),
    "club_number" : MessageLookupByLibrary.simpleMessage("Klub nummer"),
    "country" : MessageLookupByLibrary.simpleMessage("Land"),
    "create_match__handicap" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "create_match__handicap__switch_text" : MessageLookupByLibrary.simpleMessage("Spil med handicap"),
    "create_match__match_name" : MessageLookupByLibrary.simpleMessage("Match navn"),
    "create_match__match_name__hint_text" : MessageLookupByLibrary.simpleMessage("Match navn"),
    "create_match__player_invite" : MessageLookupByLibrary.simpleMessage("Inviter spillere"),
    "create_match__player_invite__club" : MessageLookupByLibrary.simpleMessage("Klub"),
    "create_match__player_invite__friends" : MessageLookupByLibrary.simpleMessage("Ven"),
    "create_match__player_invite__group" : MessageLookupByLibrary.simpleMessage("Gruppe"),
    "create_match__player_response_time" : MessageLookupByLibrary.simpleMessage("Spiller svartid"),
    "create_match__player_response_time__days" : m0,
    "create_match__question_duration" : MessageLookupByLibrary.simpleMessage("Spørgsmålsvarighed"),
    "create_match__question_duration__custom" : MessageLookupByLibrary.simpleMessage("Brugerdefineret varighed"),
    "create_match__question_duration__seconds" : m1,
    "create_match__start_button" : MessageLookupByLibrary.simpleMessage("Start"),
    "create_match__title__group_match" : MessageLookupByLibrary.simpleMessage("Gruppe match"),
    "create_match__title__solo_match" : MessageLookupByLibrary.simpleMessage("Solo"),
    "create_match__title__two_player_match" : MessageLookupByLibrary.simpleMessage("To spiller"),
    "danish" : MessageLookupByLibrary.simpleMessage("Dansk"),
    "days" : MessageLookupByLibrary.simpleMessage("Dage"),
    "dialog__are_you_sure" : MessageLookupByLibrary.simpleMessage("Er du sikker?"),
    "dialog__delete" : m2,
    "dialog__delete_from" : m3,
    "dialog__delete_group" : m4,
    "edit_profile__confirm_new_password" : MessageLookupByLibrary.simpleMessage("Bekræft ny adgangskode"),
    "edit_profile__new_password" : MessageLookupByLibrary.simpleMessage("Ny adgangskode"),
    "edit_profile__old_password" : MessageLookupByLibrary.simpleMessage("Gammelt adgangskode"),
    "edit_profile__save_loading" : MessageLookupByLibrary.simpleMessage("Gemmer din profil..."),
    "edit_profile__title" : MessageLookupByLibrary.simpleMessage("Rediger profil"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "english" : MessageLookupByLibrary.simpleMessage("Engelsk"),
    "error__data_was_not_recieved" : MessageLookupByLibrary.simpleMessage("En fejl opstod! \nVenligst kontakt vores suppport, hvis denne fejl fortsat opstår."),
    "exit" : MessageLookupByLibrary.simpleMessage("Forlad"),
    "find_player__add_popup__description" : m5,
    "find_player__add_popup__title" : m6,
    "find_player__add_popup__to_club" : MessageLookupByLibrary.simpleMessage("til klubben?"),
    "find_player__add_popup__to_friends" : MessageLookupByLibrary.simpleMessage("til dine venner?"),
    "find_player__add_popup__to_group" : MessageLookupByLibrary.simpleMessage("til gruppen?"),
    "find_player__load_players" : MessageLookupByLibrary.simpleMessage("Finder spillere..."),
    "find_player__search_player" : MessageLookupByLibrary.simpleMessage("Søg efter en spiller"),
    "find_player__search_player_hint" : MessageLookupByLibrary.simpleMessage("Søg efter en spiller"),
    "find_player__title" : MessageLookupByLibrary.simpleMessage("Find spiller"),
    "friends__add_friends_button" : MessageLookupByLibrary.simpleMessage("+ Tilføj nye venner"),
    "friends__list_first_title" : MessageLookupByLibrary.simpleMessage("Spiller"),
    "friends__list_second_title" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "friends__notification" : MessageLookupByLibrary.simpleMessage("Ny venneanmodning"),
    "friends__title" : MessageLookupByLibrary.simpleMessage("Venner"),
    "game_appbar__players" : MessageLookupByLibrary.simpleMessage("Spillere"),
    "game_appbar__question_duration" : MessageLookupByLibrary.simpleMessage("Varighed"),
    "game_appbar__your_score" : MessageLookupByLibrary.simpleMessage("Din score"),
    "game_flow__days_short" : MessageLookupByLibrary.simpleMessage("Dage"),
    "game_flow__elaborate_rule__title" : MessageLookupByLibrary.simpleMessage("Uddyb regel"),
    "game_flow__hours_short" : MessageLookupByLibrary.simpleMessage("Timer"),
    "game_flow__minutes_short" : MessageLookupByLibrary.simpleMessage("Min."),
    "game_flow__question__q_duration" : MessageLookupByLibrary.simpleMessage("Varighed"),
    "game_flow__question__title" : MessageLookupByLibrary.simpleMessage("GolfQuiz"),
    "game_flow__question__your_score" : MessageLookupByLibrary.simpleMessage("Din score"),
    "game_flow__result__continue" : MessageLookupByLibrary.simpleMessage("Fortsæt"),
    "game_flow__result__correct" : MessageLookupByLibrary.simpleMessage("Korrekt"),
    "game_flow__result__elaborate_rule" : MessageLookupByLibrary.simpleMessage("Uddyb regel"),
    "game_flow__result__friends_ranking" : MessageLookupByLibrary.simpleMessage("Venneplacering"),
    "game_flow__result__hole" : m7,
    "game_flow__result__pause_dialog" : MessageLookupByLibrary.simpleMessage("Er du sikker på du vil pause spillet?"),
    "game_flow__result__rule" : m8,
    "game_flow__result__rule_overlay__title" : MessageLookupByLibrary.simpleMessage("Uddybelse af regel"),
    "game_flow__result__scoreboard" : MessageLookupByLibrary.simpleMessage("Scoreboard"),
    "game_flow__result__wrong" : MessageLookupByLibrary.simpleMessage("Forkert"),
    "game_flow__result__your_score" : MessageLookupByLibrary.simpleMessage("Din score"),
    "game_flow__scoreboard__end_game" : MessageLookupByLibrary.simpleMessage("Afslut spil"),
    "game_flow__scoreboard__handicap" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "game_flow__scoreboard__hole" : MessageLookupByLibrary.simpleMessage("Hul"),
    "game_flow__scoreboard__pause_dialog" : MessageLookupByLibrary.simpleMessage("Er du sikker på du vil pause spillet?"),
    "game_flow__scoreboard__player" : MessageLookupByLibrary.simpleMessage("Spiller"),
    "game_flow__scoreboard__points" : MessageLookupByLibrary.simpleMessage("Points"),
    "game_flow__scoreboard__q_duration" : MessageLookupByLibrary.simpleMessage("Varighed"),
    "game_flow__scoreboard__resume" : MessageLookupByLibrary.simpleMessage("Fortsæt"),
    "game_flow__scoreboard__time" : MessageLookupByLibrary.simpleMessage("Tid"),
    "game_flow__scoreboard__your_score" : MessageLookupByLibrary.simpleMessage("Din score"),
    "game_flow__seconds_short" : MessageLookupByLibrary.simpleMessage("Sek."),
    "game_list__active_matches" : MessageLookupByLibrary.simpleMessage("Aktive matcher"),
    "game_list__date_ended_at" : m9,
    "game_list__days_left" : m10,
    "game_list__days_until" : m11,
    "game_list__group_matches" : MessageLookupByLibrary.simpleMessage("Gruppe matcher"),
    "game_list__hole_out_of" : m12,
    "game_list__hours_left" : m13,
    "game_list__hours_until" : m14,
    "game_list__inactive_matches" : MessageLookupByLibrary.simpleMessage("Tidligere matcher"),
    "game_list__minutes_left" : m15,
    "game_list__minutes_until" : m16,
    "game_list__num_of_players" : m17,
    "game_list__seconds_left" : m18,
    "game_list__seconds_until" : m19,
    "game_list__solo_matches" : MessageLookupByLibrary.simpleMessage("Solo matcher"),
    "game_list__total_score" : m20,
    "game_list__tournaments_matches" : MessageLookupByLibrary.simpleMessage("Turneringsmatcher"),
    "game_list__two_player_matches" : MessageLookupByLibrary.simpleMessage("To spiller matcher"),
    "game_tournaments__are_you_sure" : MessageLookupByLibrary.simpleMessage("Er du sikker på du vil deltage i turneringen?"),
    "game_tournaments__join_tournaments" : MessageLookupByLibrary.simpleMessage("Deltag i turneringen"),
    "game_tournaments__no_tournaments" : MessageLookupByLibrary.simpleMessage("Der er ingen kommende eller igangværende turneringer..."),
    "game_tournaments__ongoing_tournaments" : MessageLookupByLibrary.simpleMessage("Igangværende turneringer"),
    "game_tournaments__start" : MessageLookupByLibrary.simpleMessage("Begynder"),
    "game_tournaments__upcoming_tournaments" : MessageLookupByLibrary.simpleMessage("Kommende turneringer"),
    "games__start_new_match" : MessageLookupByLibrary.simpleMessage("Start ny match"),
    "games__start_new_match__group_match" : MessageLookupByLibrary.simpleMessage("Gruppe match"),
    "games__start_new_match__solo_match" : MessageLookupByLibrary.simpleMessage("Solo match"),
    "games__start_new_match__two_player_match" : MessageLookupByLibrary.simpleMessage("To spiller match"),
    "games__title" : MessageLookupByLibrary.simpleMessage("Spil"),
    "games__your_matches" : MessageLookupByLibrary.simpleMessage("Dine matcher"),
    "games__your_matches__group_matches" : MessageLookupByLibrary.simpleMessage("Gruppe matcher"),
    "games__your_matches__solo_matches" : MessageLookupByLibrary.simpleMessage("Solo matcher"),
    "games__your_matches__tournament_matches" : MessageLookupByLibrary.simpleMessage("Turneringer"),
    "games__your_matches__two_player_matches" : MessageLookupByLibrary.simpleMessage("To spiller matcher"),
    "groups__create_group_title" : MessageLookupByLibrary.simpleMessage("Opret gruppe"),
    "groups__create_new_group" : MessageLookupByLibrary.simpleMessage("+ Opret ny gruppe"),
    "groups__delete_group" : MessageLookupByLibrary.simpleMessage("Slet gruppen"),
    "groups__group_list__first_title" : MessageLookupByLibrary.simpleMessage("Gruppenavn"),
    "groups__group_list__second_title" : MessageLookupByLibrary.simpleMessage("Gns. handicap"),
    "groups__notification" : MessageLookupByLibrary.simpleMessage("Ny gruppe invitation"),
    "groups__saving_group_popup" : MessageLookupByLibrary.simpleMessage("Gemmer gruppen..."),
    "groups__single_group_list__first_title" : MessageLookupByLibrary.simpleMessage("Spiller"),
    "groups__single_group_list__second_title" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "groups__title" : MessageLookupByLibrary.simpleMessage("Grupper"),
    "handicap" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "help_and_feedback__contact" : MessageLookupByLibrary.simpleMessage("greenkeeper@golfquis.com"),
    "help_and_feedback__contact_title" : MessageLookupByLibrary.simpleMessage("Kontakt os"),
    "help_and_feedback__handicap_rules" : MessageLookupByLibrary.simpleMessage("Handicap regel beskrivelse"),
    "help_and_feedback__handicap_rules_title" : MessageLookupByLibrary.simpleMessage("Golf Rule Handicap"),
    "help_and_feedback__how_to_play" : MessageLookupByLibrary.simpleMessage("Vejledning"),
    "help_and_feedback__how_to_play_title" : MessageLookupByLibrary.simpleMessage("Sådan spiller du"),
    "help_and_feedback__title" : MessageLookupByLibrary.simpleMessage("Hjælp & Feedback"),
    "hole" : MessageLookupByLibrary.simpleMessage("Hul"),
    "home__tip_of_the_day" : MessageLookupByLibrary.simpleMessage("Dagens tip"),
    "home__title" : MessageLookupByLibrary.simpleMessage("Hjem"),
    "home__tournaments" : MessageLookupByLibrary.simpleMessage("Turneringer"),
    "home__tournaments__upcomming" : MessageLookupByLibrary.simpleMessage("Kommende turneringer"),
    "home__your_status" : MessageLookupByLibrary.simpleMessage("Din status"),
    "home__your_status__bufferzone" : MessageLookupByLibrary.simpleMessage("Bufferzone"),
    "home__your_status__handicap" : MessageLookupByLibrary.simpleMessage("Handicap"),
    "home__your_status__world_rank" : MessageLookupByLibrary.simpleMessage("Verdensplacering"),
    "hours" : MessageLookupByLibrary.simpleMessage("Timer"),
    "invite_helper__group__dialog_text" : m21,
    "invite_helper__max_players" : m22,
    "invite_helper__two_player__dialog_text" : m23,
    "menu__about_button" : MessageLookupByLibrary.simpleMessage("Om appen"),
    "menu__app_settings_button" : MessageLookupByLibrary.simpleMessage("App indstillinger"),
    "menu__club_button" : MessageLookupByLibrary.simpleMessage("Klub"),
    "menu__email_error" : MessageLookupByLibrary.simpleMessage("Ingen email fundet?"),
    "menu__friends_button" : MessageLookupByLibrary.simpleMessage("Venner"),
    "menu__group_button" : MessageLookupByLibrary.simpleMessage("Grupper"),
    "menu__help_and_feedback_button" : MessageLookupByLibrary.simpleMessage("Hjælp og feedback"),
    "menu__log_out_button" : MessageLookupByLibrary.simpleMessage("Log ud"),
    "menu__profile_button" : MessageLookupByLibrary.simpleMessage("Profil"),
    "menu__settings_section" : MessageLookupByLibrary.simpleMessage("Indstillinger"),
    "menu__status_button" : MessageLookupByLibrary.simpleMessage("Status"),
    "menu__title" : MessageLookupByLibrary.simpleMessage("Menu"),
    "mins" : MessageLookupByLibrary.simpleMessage("Min"),
    "name" : MessageLookupByLibrary.simpleMessage("Navn"),
    "no" : MessageLookupByLibrary.simpleMessage("Nej"),
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "player" : MessageLookupByLibrary.simpleMessage("Spiller"),
    "points" : MessageLookupByLibrary.simpleMessage("Points"),
    "privacy_policy__title" : MessageLookupByLibrary.simpleMessage("Privat politik"),
    "profile__game_overview" : MessageLookupByLibrary.simpleMessage("Spil oversigt"),
    "profile__game_overview__lost" : MessageLookupByLibrary.simpleMessage("Spil tabt"),
    "profile__game_overview__played" : MessageLookupByLibrary.simpleMessage("Spillede spil"),
    "profile__game_overview__won" : MessageLookupByLibrary.simpleMessage("Spil vundet"),
    "profile__title" : MessageLookupByLibrary.simpleMessage("Min profil"),
    "progressbar_text" : MessageLookupByLibrary.simpleMessage("Din fremdrift"),
    "rank" : MessageLookupByLibrary.simpleMessage("Placering"),
    "resume" : MessageLookupByLibrary.simpleMessage("Fortsæt"),
    "save" : MessageLookupByLibrary.simpleMessage("Gem"),
    "secs" : MessageLookupByLibrary.simpleMessage("Sek"),
    "status" : MessageLookupByLibrary.simpleMessage("Status"),
    "status__game_overview_title" : MessageLookupByLibrary.simpleMessage("Spil oversigt"),
    "status__games_lost" : MessageLookupByLibrary.simpleMessage("Spil tabt"),
    "status__games_played" : MessageLookupByLibrary.simpleMessage("Spillede spil"),
    "status__games_won" : MessageLookupByLibrary.simpleMessage("Spil vundet"),
    "status__ranking_club_button" : MessageLookupByLibrary.simpleMessage("Klub placering"),
    "status__ranking_club_overlay" : MessageLookupByLibrary.simpleMessage("Klub placering"),
    "status__ranking_friends_button" : MessageLookupByLibrary.simpleMessage("Venneplacering"),
    "status__ranking_friends_overlay" : MessageLookupByLibrary.simpleMessage("Venneplacering"),
    "status__ranking_title" : MessageLookupByLibrary.simpleMessage("Placering"),
    "status__ranking_world_overlay" : MessageLookupByLibrary.simpleMessage("Verdensplacering"),
    "status__title" : MessageLookupByLibrary.simpleMessage("Status"),
    "terms_conditions__title" : MessageLookupByLibrary.simpleMessage("Vilkår og betingelser"),
    "time" : MessageLookupByLibrary.simpleMessage("Tid"),
    "validation__dgu_number" : MessageLookupByLibrary.simpleMessage("Klub nummer bør være 5 tal"),
    "validation__enter_name" : MessageLookupByLibrary.simpleMessage("Indtast et navn for at søge"),
    "validation__enter_valid_email" : MessageLookupByLibrary.simpleMessage("Skriv en gyldig email"),
    "validation__password_not_the_same" : MessageLookupByLibrary.simpleMessage("Adgangskode skal være den samme"),
    "validation__reenter_password" : MessageLookupByLibrary.simpleMessage("Venligst genindtast adgangskode"),
    "validation__too_long" : m24,
    "validation__too_short" : m25,
    "validation__too_short_password" : MessageLookupByLibrary.simpleMessage("Adgangskoden skal være længere end 6 bogstaver"),
    "world_rank" : MessageLookupByLibrary.simpleMessage("Verdensplacering"),
    "yes" : MessageLookupByLibrary.simpleMessage("Ja"),
    "you" : MessageLookupByLibrary.simpleMessage("Dig")
  };
}
