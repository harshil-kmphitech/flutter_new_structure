import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppStyles {
  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontSize: AppFonts.fontSizeExtraLarge,
    fontWeight: AppFonts.fontWeightBold,
    color: AppColors.text,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: AppFonts.fontSizeLarge,
    fontWeight: AppFonts.fontWeightMedium,
    color: AppColors.text,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: AppFonts.fontSizeMedium,
    fontWeight: AppFonts.fontWeightRegular,
    color: AppColors.text,
  );

  static const TextStyle bodyTextLight = TextStyle(
    fontSize: AppFonts.fontSizeMedium,
    fontWeight: AppFonts.fontWeightRegular,
    color: AppColors.textLight,
  );

  // Input Field Style
  static InputDecoration inputFieldStyle(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: AppColors.inputFieldBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    );
  }

  // Button Style
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: AppColors.primary,
    textStyle: const TextStyle(
      fontWeight: AppFonts.fontWeightBold,
      fontSize: AppFonts.fontSizeMedium,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
