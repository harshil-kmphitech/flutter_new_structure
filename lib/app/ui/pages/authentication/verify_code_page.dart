import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/controllers/auth_controller.dart';
import 'package:flutter_new_structure/app/ui/widgets/custom_textfields.dart';
import 'package:flutter_new_structure/app/utils/constants/app_strings.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/getItHook/getit_hook.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

class VerifyCodePage extends GetItHook<AuthController> {
  const VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.T.verifyCode),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextInputField(
                type: InputType.digits,
                controller: controller.verificationCode,
                hintLabel: AppStrings.T.codeLabel,
                validator: AppValidations.verificationCodeValidation,
              ),
              Obx(
                () => controller.verificationState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: () => controller.verifyCode(context),
                            child: Text(AppStrings.T.verifyCode),
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
    controller.verificationCode.clear();
  }

  @override
  void onDispose() {}
}
