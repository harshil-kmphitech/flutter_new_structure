import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/constants/app_colors.dart';

part 'app_colors.dart';
part 'app_styles.dart';

// TextTheme textTheme = Get.theme.textTheme;
// ColorScheme colorScheme = Get.theme.colorScheme;

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    extensions: [
      const AppColors(),
      AppStyles(
        s12w500: const Outfit(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: KAppColors.primaryColor,
        ),
      ),
    ],

    colorScheme: ColorScheme(
      brightness: Brightness.light,

      ///primary
      primary: KAppColors.primaryColor,
      onPrimary: KAppColors.white,
      primaryContainer: KAppColors.bgOneColor,

      ///secondary
      secondary: KAppColors.secondaryColor,
      onSecondary: KAppColors.black,
      secondaryContainer: KAppColors.greyTextColor,

      ///Error
      error: KAppColors.red,
      onError: KAppColors.red,

      /// Field Bg Color & Text Selection
      surface: KAppColors.bgTwoColor,

      ///Please Make Sure onSurface should be Primary Color
      onSurface: KAppColors.primaryColor,

      /// Borders
      outline: KAppColors.primaryColor,
    ),
    scaffoldBackgroundColor: KAppColors.white,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return KAppColors.white; // Active thumb color
        }
        return KAppColors.red; // Inactive thumb color
      }),
      trackColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return KAppColors.greyTextColor.withOpacity(0.5);
          }
          return KAppColors.red.withOpacity(0.5);
        },
      ),
      thumbIcon: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(
            Icons.done,
            color: KAppColors.primaryColor,
          );
        }
        return null;
      }),
    ),

    /// Whenever your use the AppBar make sure most of the scenario your AppBar theme is must be sat here.
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: KAppColors.primaryColor,
      titleTextStyle: Outfit(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: KAppColors.white,
      ),
      iconTheme: IconThemeData(color: KAppColors.white),
    ),

    /// If you app supports a single FontFamily, So this is the best way to change FontFamily for allover the app.
    fontFamily: 'Outfit',
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      visualDensity: VisualDensity.compact,
      fillColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return KAppColors.primaryColor;
          }
          return KAppColors.white;
        },
      ),
    ),

    /// InputDecorationTheme is used for make you TextFormField, DropDownFormField and many more widget.
    /// Those Widget Which is depended on InputDecorationTheme.
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: KAppColors.greyTextColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: KAppColors.red),
      ),
      contentPadding: const EdgeInsets.all(8),
      errorStyle: const Outfit(color: KAppColors.red, fontSize: 12, fontWeight: FontWeight.w600),
      hintStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: KAppColors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: KAppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );
        },
      ),
      labelStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: KAppColors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: KAppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );
        },
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: KAppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: KAppColors.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        },
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: KAppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dividerColor: KAppColors.bgOneColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: KAppColors.primaryColor,
    ),
    textTheme: TextTheme(
      /// Used for Headline Like AppBar And Other Titles which are largest in Ui.
      headlineLarge: const Outfit(color: KAppColors.black, fontSize: 26, fontWeight: FontWeight.w600),
      headlineMedium: const Outfit(color: KAppColors.black, fontSize: 22, fontWeight: FontWeight.w600),
      headlineSmall: const Outfit(color: KAppColors.black, fontSize: 20, fontWeight: FontWeight.w600),

      ///  title styles:  are smaller than headline styles and should be used for shorter, medium-emphasis text.

      /// Used For Most Used Styles
      bodyLarge: const Outfit(color: KAppColors.black, fontSize: 20, fontWeight: FontWeight.w500),
      bodyMedium: const Outfit(color: KAppColors.black, fontSize: 18, fontWeight: FontWeight.w500),
      bodySmall: const Outfit(color: KAppColors.black, fontSize: 16, fontWeight: FontWeight.w500),

      ///USED for Description and Small Text.
      labelLarge: Outfit(color: KAppColors.greyTextColor, fontSize: 18, fontWeight: FontWeight.w400),
      labelMedium: Outfit(color: KAppColors.greyTextColor, fontSize: 16, fontWeight: FontWeight.w400),
      labelSmall: Outfit(color: KAppColors.greyTextColor, fontSize: 14, fontWeight: FontWeight.w400),

      //   Also U can add More TextStyle According Your Design
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    extensions: [
      AppStyles(
        s12w500: const Outfit(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: KAppColors.blackColor,
        ),
      ),
    ],
    colorScheme: ColorScheme(
      brightness: Brightness.dark,

      ///primary
      primary: KAppColors.primaryColor,
      onPrimary: KAppColors.black,
      primaryContainer: KAppColors.bgOneColor,

      ///secondary
      secondary: KAppColors.secondaryColor,
      onSecondary: KAppColors.white,
      secondaryContainer: KAppColors.greyTextColor,

      ///Error
      error: KAppColors.red,
      onError: KAppColors.red,

      /// Field Bg Color & Text Selection
      surface: KAppColors.bgTwoColor,

      ///Please Make Sure onSurface should be Primary Color
      onSurface: KAppColors.primaryColor,

      /// Borders
      outline: KAppColors.primaryColor,
    ),
    scaffoldBackgroundColor: KAppColors.black,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return KAppColors.white; // Active thumb color
        }
        return KAppColors.red; // Inactive thumb color
      }),
      trackColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return KAppColors.greyTextColor.withOpacity(0.5);
          }
          return KAppColors.red.withOpacity(0.5);
        },
      ),
      thumbIcon: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(
            Icons.done,
            color: KAppColors.primaryColor,
          );
        }
        return null;
      }),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: KAppColors.primaryColor,
      titleTextStyle: Outfit(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: KAppColors.white,
      ),
      iconTheme: IconThemeData(color: KAppColors.black),
    ),
    fontFamily: 'Outfit',
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      visualDensity: VisualDensity.compact,
      fillColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return KAppColors.primaryColor;
          }
          return KAppColors.black;
        },
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: KAppColors.greyTextColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: KAppColors.red),
      ),
      contentPadding: const EdgeInsets.all(8),
      errorStyle: const Outfit(color: KAppColors.red, fontSize: 12, fontWeight: FontWeight.w600),
      hintStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: KAppColors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: KAppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );
        },
      ),
      labelStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: KAppColors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: KAppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );
        },
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: KAppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: KAppColors.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        },
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: KAppColors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dividerColor: KAppColors.bgOneColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: KAppColors.primaryColor,
    ),
  );
}
