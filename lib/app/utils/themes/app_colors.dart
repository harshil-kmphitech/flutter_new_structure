part of 'app_theme.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors();

  static const Color tempPrimary = Color.fromRGBO(30, 76, 206, 1);

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  @override
  ThemeExtension<AppColors> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return other;
  }
}
