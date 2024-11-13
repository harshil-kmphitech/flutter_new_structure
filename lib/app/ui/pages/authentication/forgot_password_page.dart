import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/app_messages.dart';
import '../../../utils/helpers/injectable/injectable.dart';
import '../../widgets/custom_textfields.dart';

class ForgotPasswordPage extends StatelessWidget {
  final AuthController _authController = getIt<AuthController>();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppMessages.forgotPasswordPageTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInputField(
                type: InputType.email,
                controller: _authController.forgotEmailController,
                hintLabel: AppMessages.emailLabel,
                validator: AppValidations.emailValidation,
              ),
              Obx(
                () => _authController.forgotState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(builder: (context) {
                        return ElevatedButton(
                          onPressed: () => _authController.forgotPassword(context),
                          child: const Text(AppMessages.sendResetLinkButton),
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
