import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_new_structure/app/controllers/auth_controller.dart';
import 'package:flutter_new_structure/app/utils/constants/app_strings.dart';
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/helpers/all_imports.dart';
import '../../../utils/helpers/injectable/injectable.dart';

class ThemePage extends GetView<AuthController> {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AuthController controller = getIt<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.T.welcome('User')),
        centerTitle: true,
      ),
      body: ListView(
        primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          const Text(
            "Default Text",
          ),
          12.heightBox,
          Text(
            "Headline Large",
            style: textTheme.headlineLarge,
          ),
          Text(
            "Headline Medium",
            style: textTheme.headlineMedium,
          ),
          Text(
            "Headline Small",
            style: textTheme.headlineSmall,
          ),
          12.heightBox,
          Text(
            "Body Large",
            style: textTheme.bodyLarge,
          ),
          Text(
            "Body Medium",
            style: textTheme.bodyMedium,
          ),
          Text(
            "Body Small",
            style: textTheme.bodySmall,
          ),
          12.heightBox,
          Text(
            "Label Large",
            style: textTheme.labelLarge,
          ),
          Text(
            "Label Medium",
            style: textTheme.labelMedium,
          ),
          Text(
            "Label Small",
            style: textTheme.labelSmall,
          ),
          const SizedBox(height: 16),
          const TextField(),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            value: Locale(getIt<SharedPreferences>().getAppLocal ?? 'en'),
            items: AppLocalizations.supportedLocales.map(
              (e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.languageCode),
                );
              },
            ).toList(),
            onChanged: (value) {
              if (value == null) return;
              getIt<SharedPreferences>().setAppLocal = value.languageCode;
              Get.updateLocale(value);
            },
          ),
          Obx(() {
            return Row(
              children: [
                Switch(
                  value: controller.isDarkTheme.value,
                  onChanged: (value) {
                    controller.isDarkTheme.value = !controller.isDarkTheme.value;
                    if (value) {
                      Get.changeThemeMode(ThemeMode.dark);
                    } else {
                      Get.changeThemeMode(ThemeMode.light);
                    }
                  },
                ),
                Checkbox(
                  value: controller.isDarkTheme.value,
                  onChanged: (value) {
                    controller.isDarkTheme.value = !controller.isDarkTheme.value;
                    if (value ?? false) {
                      Get.changeThemeMode(ThemeMode.dark);
                    } else {
                      Get.changeThemeMode(ThemeMode.light);
                    }
                  },
                ),
                12.widthBox,
                const CircularProgressIndicator(),
              ],
            );
          }),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.primary,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.primary',
                      style: textTheme.labelSmall?.copyWith(color: colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.onPrimary',
                      style: textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.primaryContainer,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.primaryContainer',
                      style: textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.secondary,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.secondary',
                      style: textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.onSecondary,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.onSecondary',
                      style: textTheme.labelSmall?.copyWith(color: colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.secondaryContainer,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.secondaryContainer',
                      style: textTheme.labelSmall?.copyWith(color: colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.error,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.error',
                      style: textTheme.labelSmall?.copyWith(color: colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onError,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.onError',
                      style: textTheme.labelSmall?.copyWith(color: colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.surface,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.surface',
                      style: textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onSurface,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.onSurface',
                      style: textTheme.labelSmall?.copyWith(color: colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
          4.heightBox,
          Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.outline,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Text(
                      'colorScheme.outline',
                      style: textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ).paddingAll(20.r),
    );
  }
}
