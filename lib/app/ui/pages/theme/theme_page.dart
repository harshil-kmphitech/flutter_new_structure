import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_new_structure/app/controllers/auth_controller.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/utils/constants/app_edge_insets.dart';
import 'package:flutter_new_structure/app/utils/constants/app_strings.dart';
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:flutter_new_structure/app/utils/helpers/getItHook/getit_hook.dart';
import 'package:flutter_new_structure/app/utils/helpers/injectable/injectable.dart';
import 'package:flutter_new_structure/app/utils/helpers/logger.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePage extends GetItHook<AuthController> {
  const ThemePage({super.key});

  static Future<T?>? offAllRoute<T>() {
    return Get.offAllNamed(AppRoutes.theme);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final controller = getIt<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.T.welcome(controller.emailController.text)),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          const gap12 = Gap(12);
          const gap16 = Gap(16);

          return ListView(
            padding: MediaQuery.paddingOf(context).add(const AppEdgeInsets.h16()),
            children: [
              const Text(
                'Default Text',
              ),
              gap12,
              Text(
                'Display Large',
                style: textTheme.displayLarge.log,
              ),
              Text(
                'Display Medium',
                style: textTheme.displayMedium,
              ),
              Text(
                'Display Small',
                style: textTheme.displaySmall,
              ),
              gap12,
              Text(
                'Headline Large',
                style: textTheme.headlineLarge,
              ),
              Text(
                'Headline Medium',
                style: textTheme.headlineMedium,
              ),
              Text(
                'Headline Small',
                style: textTheme.headlineSmall,
              ),
              gap12,
              Text(
                'Body Large',
                style: textTheme.bodyLarge,
              ),
              Text(
                'Body Medium',
                style: textTheme.bodyMedium,
              ),
              Text(
                'Body Small',
                style: textTheme.bodySmall,
              ),
              gap12,
              Text(
                'Title Large',
                style: textTheme.titleLarge,
              ),
              Text(
                'Title Medium',
                style: textTheme.titleMedium,
              ),
              Text(
                'Title Small',
                style: textTheme.titleSmall,
              ),
              gap12,
              Text(
                'Label Large',
                style: textTheme.labelLarge,
              ),
              Text(
                'Label Medium',
                style: textTheme.labelMedium,
              ),
              Text(
                'Label Small',
                style: textTheme.labelSmall,
              ),
              gap16,
              const TextField(),
              gap16,
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
              Row(
                children: [
                  Switch(
                    value: controller.isDarkTheme,
                    onChanged: (value) {
                      controller.isDarkTheme = !controller.isDarkTheme;

                      if (value) {
                        Get.changeThemeMode(ThemeMode.dark);
                      } else {
                        Get.changeThemeMode(ThemeMode.light);
                      }
                    },
                  ),
                  Checkbox(
                    value: controller.isDarkTheme,
                    onChanged: (value) {
                      controller.isDarkTheme = !controller.isDarkTheme;

                      if (value ?? false) {
                        Get.changeThemeMode(ThemeMode.dark);
                      } else {
                        Get.changeThemeMode(ThemeMode.light);
                      }
                    },
                  ),
                  const Gap(12),
                  const CircularProgressIndicator(),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
              const Gap(4),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: colorScheme.outline,
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
          );
        },
      ),
    );
  }

  @override
  bool get canDisposeController => true;

  @override
  void onDispose() {}

  @override
  void onInit() {}
}
