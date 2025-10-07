import 'package:flutter/material.dart';

part 'app_button_theme.dart';
part 'app_colors.dart';
part 'app_icon_button_theme.dart';
part 'app_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    extensions: const [AppColors(), AppStyles()],
    buttonTheme: _buttonTheme,
    appBarTheme: _appBarTheme,
    fontFamily: _kOutfitFontFamily,
    inputDecorationTheme: _inputDecorationTheme,
    bottomSheetTheme: _bottomSheetTheme,
    progressIndicatorTheme: _progressIndicatorTheme,
  );

  static ProgressIndicatorThemeData get _progressIndicatorTheme {
    return const ProgressIndicatorThemeData();
  }

  static BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return const InputDecorationTheme(
      contentPadding: EdgeInsets.all(8),
      // TODO: Add ErrorStyle
      // errorStyle: ,
      // TODO: Add hintStyle
      // hintStyle: ,
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(titleTextStyle: Outfit(fontSize: 24, fontWeight: FontWeight.w600));
  }

  static ButtonThemeData get _buttonTheme {
    return const ButtonThemeData();
  }
}

class TextFieldStyleProvider extends InheritedWidget {
  const TextFieldStyleProvider({super.key, required this.style, required super.child});

  final TextStyle style;

  static final styleKey = GlobalKey();

  static TextStyle? get styleOf {
    return styleKey.currentContext
        ?.dependOnInheritedWidgetOfExactType<TextFieldStyleProvider>()
        ?.style;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is! TextFieldStyleProvider) return false;

    return style != oldWidget.style;
  }
}
