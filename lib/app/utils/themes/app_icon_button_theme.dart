part of 'app_theme.dart';

enum AppIconButtonType { primary }

class AppIconButtonTheme extends ThemeExtension<AppIconButtonTheme> {
  const AppIconButtonTheme._({this.primary = const ButtonStyle()});

  final ButtonStyle primary;

  static AppIconButtonTheme of(BuildContext context) {
    return Theme.of(context).extension<AppIconButtonTheme>()!;
  }

  @override
  ThemeExtension<AppIconButtonTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppIconButtonTheme> lerp(
    covariant ThemeExtension<AppIconButtonTheme>? other,
    double t,
  ) {
    if (other is! AppIconButtonTheme) {
      return this;
    }
    return other;
  }
}
