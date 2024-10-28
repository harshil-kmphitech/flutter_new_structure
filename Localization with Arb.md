# Localization with Arb

### Add dependencies:

`pubspec.yaml` add `flutter_localizations` and `intl`. make sure implements as provided.
```
dependencies: 
  flutter: 
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: any
```

enable generate localization. add `generate: true`

```
flutter: 
  uses-material-design: true
  generate: true
```

and check out the files [app_en.dart](https://github.com/harshil-kmphitech/flutter_new_structure/blob/Jay-Padsala/lib/l10n/app_en.dart) and [app_hi.dart](https://github.com/harshil-kmphitech/flutter_new_structure/blob/Jay-Padsala/lib/l10n/app_hi.dart)

run command for generate localizations.
```
flutter gen-l10n
```

add the following code in `main.dart`

you have to manually import the `flutter_gen`

```
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

```
MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
)
```
[check here](https://github.com/harshil-kmphitech/flutter_new_structure/blob/Jay-Padsala/lib/main.dart)

**Access Localized Strings:**

```
class AppStrings {
  static AppLocalizations get T => AppLocalizations.of(Get.context!)!;
}

AppStrings.T.title; // usage
```

[check here](https://github.com/harshil-kmphitech/flutter_new_structure/blob/Jay-Padsala/lib/app/utils/constants/app_strings.dart)