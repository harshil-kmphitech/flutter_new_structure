part of 'app_theme.dart';

enum AppButtonType { primary }

class AppButtonThemes extends ThemeExtension<AppButtonThemes> {
  const AppButtonThemes({this.primary = const ButtonStyle()});

  final ButtonStyle primary;

  static AppButtonThemes of(BuildContext context) {
    return Theme.of(context).extension<AppButtonThemes>()!;
  }

  @override
  ThemeExtension<AppButtonThemes> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppButtonThemes> lerp(covariant ThemeExtension<AppButtonThemes>? other, double t) {
    if (other is! AppButtonThemes) {
      return this;
    }

    return other;
  }
}
