import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/utils/helpers/all_imports.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/helpers/getItHook/getit_hook.dart';
import '../../widgets/custom_textfields.dart';

class LoginPage extends GetItHook<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var passObscure = true.obs;

    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.T.login),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextInputField(
                  type: InputType.text,
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
                    controller
                      ..forgotEmailController.clear()
                      ..resetPassController.clear()
                      ..confirmPassController.clear();
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
  void init() {
    controller.emailController.clear();
    controller.passController.clear();
  }

  @override
  void onDispose() {}
}
