import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

// TextTheme textTheme = Get.theme.textTheme;
// ColorScheme colorScheme = Get.theme.colorScheme;

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
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
    appBarTheme: AppBarTheme(
      elevation: 0.h,
      color: AppColors.primaryColor,
      titleTextStyle: TextStyle(
        fontFamily: "Outfit",
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      iconTheme: const IconThemeData(color: AppColors.black),
    ),
    fontFamily: "Outfit",
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      visualDensity: VisualDensity.compact,
      fillColor: WidgetStateProperty.resolveWith(
        (Set states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.white;
        },
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
    ),
    dividerColor: AppColors.bgOneColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      /// Used for Headline Like AppBar And Other Titles which are largest in Ui.
      headlineLarge: TextStyle(color: AppColors.black, fontSize: 26.sp, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(color: AppColors.black, fontSize: 22.sp, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w600),

      ///  title styles:  are smaller than headline styles and should be used for shorter, medium-emphasis text.
      // titleLarge: ,

      /// Used For Most Used Styles
      bodyLarge: TextStyle(color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color: AppColors.black, fontSize: 18.sp, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),

      ///USED for Description and Small Text.
      labelLarge: TextStyle(color: AppColors.greyTextColor, fontSize: 18.sp, fontWeight: FontWeight.w400),
      labelMedium: TextStyle(color: AppColors.greyTextColor, fontSize: 16.sp, fontWeight: FontWeight.w400),
      labelSmall: TextStyle(color: AppColors.greyTextColor, fontSize: 14.sp, fontWeight: FontWeight.w400),

      //   Also U can add More TextStyle According Your Design
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
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
    appBarTheme: AppBarTheme(
      elevation: 0.h,
      color: AppColors.primaryColor,
      titleTextStyle: TextStyle(
        fontFamily: "Outfit",
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      iconTheme: const IconThemeData(color: AppColors.black),
    ),
    fontFamily: "Outfit",
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      visualDensity: VisualDensity.compact,
      fillColor: WidgetStateProperty.resolveWith(
        (Set states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.black;
        },
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
    ),
    dividerColor: AppColors.bgOneColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      /// Used for Headline Like AppBar And Other Titles which are largest in Ui.
      headlineLarge: TextStyle(color: AppColors.white, fontSize: 26.sp, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(color: AppColors.white, fontSize: 22.sp, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: AppColors.white, fontSize: 20.sp, fontWeight: FontWeight.w600),

      ///  title styles:  are smaller than headline styles and should be used for shorter, medium-emphasis text.
      // titleLarge: ,

      /// Used For Most Used Styles
      bodyLarge: TextStyle(color: AppColors.white, fontSize: 20.sp, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w500),

      ///USED for Description and Small Text.
      labelLarge: TextStyle(color: AppColors.bgOneColor, fontSize: 18.sp, fontWeight: FontWeight.w400),
      labelMedium: TextStyle(color: AppColors.bgOneColor, fontSize: 16.sp, fontWeight: FontWeight.w400),
      labelSmall: TextStyle(color: AppColors.bgOneColor, fontSize: 14.sp, fontWeight: FontWeight.w400),

      //   Also U can add More TextStyle According Your Design
    ),
  );
}
