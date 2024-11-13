import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/helpers/injectable/injectable.dart';
import '../../widgets/custom_textfields.dart';

class VerifyCodePage extends StatelessWidget {
  final AuthController _authController = getIt<AuthController>();

  VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.T.verifyCode),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextInputField(
                type: InputType.digits,
                controller: _authController.verificationCode,
                hintLabel: AppStrings.T.codeLabel,
                validator: AppValidations.verificationCodeValidation,
              ),
              Obx(
                () => _authController.verificationState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(builder: (context) {
                        return ElevatedButton(
                          onPressed: () => _authController.verifyCode(context),
                          child: Text(AppStrings.T.verifyCode),
                        );
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
