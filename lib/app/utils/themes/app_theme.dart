import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/constants/app_colors.dart';

part 'app_styles.dart';

// TextTheme textTheme = Get.theme.textTheme;
// ColorScheme colorScheme = Get.theme.colorScheme;

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    extensions: [AppStyles()],

    colorScheme: ColorScheme(
      brightness: Brightness.light,

      ///primary
      primary: AppColors.primaryColor,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.bgOneColor,

      ///secondary
      secondary: AppColors.secondaryColor,
      onSecondary: AppColors.black,
      secondaryContainer: AppColors.greyTextColor,

      ///Error
      error: AppColors.red,
      onError: AppColors.red,

      /// Field Bg Color & Text Selection
      surface: AppColors.bgTwoColor,

      ///Please Make Sure onSurface should be Primary Color
      onSurface: AppColors.primaryColor,

      /// Borders
      outline: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.white,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white; // Active thumb color
        }
        return AppColors.red; // Inactive thumb color
      }),
      trackColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.greyTextColor.withOpacity(0.5);
          }
          return AppColors.red.withOpacity(0.5);
        },
      ),
      thumbIcon: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(
            Icons.done,
            color: AppColors.primaryColor,
          );
        }
        return null;
      }),
    ),

    /// Whenever your use the AppBar make sure most of the scenario your AppBar theme is must be sat here.
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: AppColors.primaryColor,
      titleTextStyle: Outfit(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      iconTheme: IconThemeData(color: AppColors.white),
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
            return AppColors.primaryColor;
          }
          return AppColors.white;
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
        borderSide: BorderSide(color: AppColors.greyTextColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      contentPadding: const EdgeInsets.all(8),
      errorStyle: const Outfit(color: AppColors.red, fontSize: 12, fontWeight: FontWeight.w600),
      hintStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: AppColors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );
        },
      ),
      labelStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: AppColors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );
        },
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: AppColors.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        },
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dividerColor: AppColors.bgOneColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      /// Used for Headline Like AppBar And Other Titles which are largest in Ui.
      headlineLarge: const Outfit(color: AppColors.black, fontSize: 26, fontWeight: FontWeight.w600),
      headlineMedium: const Outfit(color: AppColors.black, fontSize: 22, fontWeight: FontWeight.w600),
      headlineSmall: const Outfit(color: AppColors.black, fontSize: 20, fontWeight: FontWeight.w600),

      ///  title styles:  are smaller than headline styles and should be used for shorter, medium-emphasis text.

      /// Used For Most Used Styles
      bodyLarge: const Outfit(color: AppColors.black, fontSize: 20, fontWeight: FontWeight.w500),
      bodyMedium: const Outfit(color: AppColors.black, fontSize: 18, fontWeight: FontWeight.w500),
      bodySmall: const Outfit(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w500),

      ///USED for Description and Small Text.
      labelLarge: Outfit(color: AppColors.greyTextColor, fontSize: 18, fontWeight: FontWeight.w400),
      labelMedium: Outfit(color: AppColors.greyTextColor, fontSize: 16, fontWeight: FontWeight.w400),
      labelSmall: Outfit(color: AppColors.greyTextColor, fontSize: 14, fontWeight: FontWeight.w400),

      //   Also U can add More TextStyle According Your Design
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    extensions: [AppStyles()],
    colorScheme: ColorScheme(
      brightness: Brightness.dark,

      ///primary
      primary: AppColors.primaryColor,
      onPrimary: AppColors.black,
      primaryContainer: AppColors.bgOneColor,

      ///secondary
      secondary: AppColors.secondaryColor,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.greyTextColor,

      ///Error
      error: AppColors.red,
      onError: AppColors.red,

      /// Field Bg Color & Text Selection
      surface: AppColors.bgTwoColor,

      ///Please Make Sure onSurface should be Primary Color
      onSurface: AppColors.primaryColor,

      /// Borders
      outline: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.black,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white; // Active thumb color
        }
        return AppColors.red; // Inactive thumb color
      }),
      trackColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.greyTextColor.withOpacity(0.5);
          }
          return AppColors.red.withOpacity(0.5);
        },
      ),
      thumbIcon: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(
            Icons.done,
            color: AppColors.primaryColor,
          );
        }
        return null;
      }),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: AppColors.primaryColor,
      titleTextStyle: Outfit(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      iconTheme: IconThemeData(color: AppColors.black),
    ),
    fontFamily: 'Outfit',
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      visualDensity: VisualDensity.compact,
      fillColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.black;
        },
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.greyTextColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      contentPadding: const EdgeInsets.all(8),
      errorStyle: const Outfit(color: AppColors.red, fontSize: 12, fontWeight: FontWeight.w600),
      hintStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: AppColors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );
        },
      ),
      labelStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: AppColors.red,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );
        },
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return const Outfit(
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            );
          }
          return const Outfit(
            color: AppColors.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        },
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dividerColor: AppColors.bgOneColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
  );
}
