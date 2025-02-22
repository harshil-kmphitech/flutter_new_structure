part of 'app_theme.dart';

const _kOutfitFontFamily = 'Outfit';

class Outfit extends TextStyle {
  const Outfit({
    super.fontSize,
    super.color,
    super.decoration,
    super.fontWeight,
    super.overflow,
    super.decorationColor,
    super.height,
  }) : super(fontFamily: _kOutfitFontFamily);
}

class AppStyles extends ThemeExtension<AppStyles> {
  AppStyles({required this.s12w500});

  final TextStyle s12w500;

  static AppStyles of(BuildContext context) {
    return Theme.of(context).extension<AppStyles>()!;
  }

  @override
  ThemeExtension<AppStyles> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppStyles> lerp(covariant ThemeExtension<AppStyles>? other, double t) {
    if (other is! AppStyles) {
      return this;
    }

    return other;
  }
}
