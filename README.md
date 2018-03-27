# flutter_todo

Sample todo application that using flutter.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

### Localize

ref. [https://flutter.io/tutorials/internationalization/](https://flutter.io/tutorials/internationalization/#appendix-using-the-dart-intl-tools)

1. Extract messages.
```
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i10n lib/i10n/app_localizations.dart
```

2.
```
flutter packages pub run intl_translation:generate_from_arb \
  --output-dir=lib/i10n \
  --no-use-deferred-loading \
  lib/i10n/*.dart \
  lib/i10n/*.arb
```