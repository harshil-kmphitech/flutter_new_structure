import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/controllers/auth_controller.dart';
import 'package:flutter_new_structure/app/ui/widgets/custom_textfields.dart';
import 'package:flutter_new_structure/app/utils/constants/app_strings.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/getItHook/getit_hook.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends GetItHook<AuthController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.T.forgotPassword),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInputField(
                type: InputType.email,
                controller: controller.forgotEmailController,
                hintLabel: AppStrings.T.emailLabel,
                validator: AppValidations.emailValidation,
              ),
              Obx(
                () => controller.forgotState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: () => controller.forgotPassword(context),
                            child: Text(AppStrings.T.sendResetLinkButton),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get canDisposeController => false;

  @override
  void onInit() {
    controller.forgotEmailController.clear();
  }

  @override
  void onDispose() {}
}
