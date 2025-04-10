import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/constants/app_colors.dart';
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';

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

    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      height: 50,
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
            return KAppColors.greyTextColor.changeOpacity(0.5);
          }
          return KAppColors.red.changeOpacity(0.5);
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
      errorStyle: const Outfit(
          color: KAppColors.red, fontSize: 12, fontWeight: FontWeight.w600),
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
  );
}
