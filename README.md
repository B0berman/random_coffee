# Random Coffee

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Generated by the [Very Good CLI][very_good_cli_link] 🤖

My new Flutter app to see coffee pictures

---
## Requirements

May require cocoapods (with ruby dependency) [Install Cocoapods][cocoapods_install_link]

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Random Coffee works on iOS and Android._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.
`app_en.arb`

```arb
{
    "@@locale": "en",
    "randomCoffeeAppBarTitle": "Random Coffee",
}
```

2. Then add a new key/value and description
`app_en.arb`

```arb
{
    "@@locale": "en",
    "randomCoffeeAppBarTitle": "Random Coffee",
    "@randomCoffeeAppBarTitle": {
        "description": "Text shown in the AppBar of the Random Coffee Page"
    }
}
```

3. Use the new string

```dart
import 'package:random_coffee/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "randomCoffeeAppBarTitle": "Random Coffee",
    "@randomCoffeeAppBarTitle": {
        "description": "Text shown in the AppBar of the Random Coffee Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "randomCoffeeAppBarTitle": "Random Coffee",
    "@randomCoffeeAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página de cafes aleatorios"
    }
}
```

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
[cocoapods_install_link]: https://guides.cocoapods.org/using/getting-started.html#installation
