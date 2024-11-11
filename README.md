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


## STEP 2. Responsive Ui: flutter_screenutil

### 1.`HELPER`
```
***
designSize: Size(FIGMA_WIDTH, FIGMA_HIGHT),
***

| Property          | Type             | Default Value | Description                                                                                                                                   |
| ----------------- | ---------------- | ------------- |-----------------------------------------------------------------------------------------------------------------------------------------------|
| designSize        | Size             | Size(360,690) | The size of the device screen in the design draft, in dp                                                                                      |
| splitScreenMode   | bool             | false         | support for split screen                                                                                                                      |
| minTextAdapt      | bool             | false         | Whether to adapt the text according to the minimum of width and height
                                                                     |
//for example:
.w = width Used For width
.h = height Used For height
.r = display a square based on minimum(height, width) Used For Radius
.sp = Used For TextSize

```


### 2.`Note`

#### The height can also use setWidth to ensure that it is not deformed(when you want a square)

#### The setHeight method is mainly to adapt to the height, which is used when you want to control the height of a screen on the UI to be the same as the actual display.

#### Generally speaking, 50.w!=50.h.

```
For Padding all, Radius => .r
For Height => .h
For Width => .w
For TextSize => .sp


//for example:
.w = width Used For width
.h = height Used For height
.r = display a square based on minimum(height, width) Used For Radius
.sp = Used For TextSize

//If you want to display a rectangle:
Container(
  width: 375.w,
  height: 375.h,
),

//If you want to display a square based on width:

Container(
  width: 300.w,
  height: 300.w,
),

//If you want to display a square based on height:
Container(
  width: 300.h,
  height: 300.h,
),

//If you want to display a square based on minimum(height, width):
Container(
  width: 300.r,
  height: 300.r,
),
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


