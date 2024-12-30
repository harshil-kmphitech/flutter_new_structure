# PROJECT_NAME


Flutter SDK version :-  YOUR_FLUTTER_SDK_VERSION
Dart SDK version :- YOUR_DART_SDK_VERSION
Android ToolChain :- YOUR_ANDROID_TOOLCHAIN_VERSION

figma : YOUR_FIGMA_LINK
Dev : DEVELOPER_NAME


## UI Setup

## STEP 1. Adding a Native Splash Screen

#### 1. Install the Package
Make sure you have added `flutter_native_splash` as a dependency in your `pubspec.yaml` file.

#### 2. Configure `flutter_native_splash`
Update the `pubspec.yaml` file to configure the splash screen with the desired background color and image. Here is an example configuration:

```add this at the end of pubspec yaml
flutter_native_splash:

  color: "#01070A"
  image: assets/app_Icon.png

  android_12:

    # Splash screen background color.
    color: "#01070A"
    color_android: "#01070A"
```

#### 3. Apply Splash: ```dart run flutter_native_splash:create```

#### 4. How to Use:

```
/// to keep the splash on screen
 void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  }

/// whenever your initialization is completed, remove the splash screen:
- FlutterNativeSplash.remove();
```

## STEP 2. App Theme: (Dark OR Light)

### 1.`colorScheme`


```
colorScheme:

primary: The primary color used in most parts of the app (e.g., app bar, buttons).
onPrimary: A color that's used on top of the primary color (e.g., text or icons on a primary-colored background).
secondary: The secondary color used for accents or highlighting.
onSecondary: A color that's used on top of the secondary color.
background: The background color for the app's main surfaces.
onBackground: A color used on top of the background color.
surface: The color used for surfaces of components (e.g., cards).
onSurface: A color used on top of the surface color.
error: The color used to represent errors or warnings.
onError: A color used on top of the error color.
brightness: Defines whether the theme is light or dark (Brightness.light or Brightness.dark).
```

### 2.`textTheme`

####  `Note` => bodyMedium will be used as default TextStyle

```
headline
title
body => Body styles are used for longer passages of text.
display => display styles are reserved for short, important text or numerals. They work best on large screens.
lable => used for areas of the UI such as text inside of components or very small supporting text in the content body, like captions.
```


