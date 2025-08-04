# flutter_new_structure

## Dependency Installation

To install all required dependencies at once, run the following command in your project directory:

```bash
flutter pub add cached_network_image collection crypto dio firebase_core firebase_crashlytics flutter_easyloading flutter_svg gap get get_it injectable json_annotation path_provider pretty_dio_logger retrofit shared_preferences
```

## Dev Dependency Installation

To install all required dev dependencies, run:

```bash
flutter pub add --dev retrofit_generator build_runner json_serializable injectable_generator flutter_gen_runner
```

## Additional Dependencies

You can add the following dependencies directly using the command line:

```bash
flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl
```

Alternatively, add them manually to your `pubspec.yaml` under `dependencies`:

```yaml
flutter_localizations:
    sdk: flutter
intl: any
```
## Final Step: Run `flutter pub get`

After adding all dependencies to your `pubspec.yaml`, run the following command to fetch and install them:

```bash
flutter pub get
```
## Enabling Code Generation

To enable code generation in your project, add the following section to your `pubspec.yaml` file:

```yaml
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true
  generate: true # do it
```

This ensures that code generation tools are activated and ready to use.