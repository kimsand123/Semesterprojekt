## To extract the initial translation:

flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/localization/l10n lib/localization/appLocalizations.dart

## Rename the .arb files to match languages ex. 'intl_da.arb'

## To import the translations:

flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/localization/l10n --no-use-deferred-loading lib/localization/appLocalizations.dart lib/localization/l10n/intl_*.arb

## Implementation

AppLocalizations.of(context).auth_intro_title