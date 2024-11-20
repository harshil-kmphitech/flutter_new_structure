import 'package:flutter_new_structure/app/controllers/auth_controller.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/ui/widgets/custom_textfields.dart';
import 'package:flutter_new_structure/app/utils/constants/app_strings.dart';
import 'package:flutter_new_structure/app/utils/helpers/all_imports.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/getItHook/getit_hook.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';

class LoginPage extends GetItHook<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final passObscure = true.obs;

    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.T.login),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextInputField(
                  type: InputType.email,
                  controller: controller.emailController,
                  hintLabel: AppStrings.T.emailLabel,
                  validator: AppValidations.emailValidation,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextInputField(
                    type: InputType.password,
                    controller: controller.passController,
                    hintLabel: AppStrings.T.passwordLabel,
                    obscureText: passObscure,
                    textInputAction: TextInputAction.done,
                    validator: AppValidations.passwordValidation,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: MediaQuery.sizeOf(context).width > 600 ? Alignment.centerRight : Alignment.centerLeft,
                  child: Obx(
                    () => controller.loginState.isLoading
                        ? const CircularProgressIndicator()
                        : Builder(
                            builder: (context) {
                              return SizedBox(
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: () => controller.login(context),
                                  child: Text(
                                    AppStrings.T.login,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.register),
                  child: Text(AppStrings.T.registerRedirect),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.forgotPassword);
                  },
                  child: Text(AppStrings.T.forgotPasswordRedirect),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.theme),
                  child: Text(AppStrings.T.theme),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get canDisposeController => false;

  @override
  void onInit() {
    controller.emailController.clear();
    controller.passController.clear();
  }

  @override
  void onDispose() {}
}
