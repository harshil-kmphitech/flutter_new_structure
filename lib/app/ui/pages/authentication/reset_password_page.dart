import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/app_messages.dart';
import '../../../utils/helpers/exception/exception.dart';
import '../../../utils/helpers/injectable/injectable.dart';

class ResetPasswordPage extends StatelessWidget {
  final AuthController _authController = getIt<AuthController>();

  ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppMessages.resetPasswordPageTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: AppMessages.newPasswordLabel),
                obscureText: true,
                controller: _authController.resetPassController,
                validator: AppValidations.passwordValidation,
              ),
              TextFormField(
                controller: _authController.confirmPassController,
                validator: (value) => AppValidations.confirmPasswordValidation(value, _authController.passController.text),
                decoration: const InputDecoration(labelText: AppMessages.confirmPasswordLabel),
                obscureText: true,
              ),
              Obx(
                () => _authController.resetPassState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(builder: (context) {
                        return ElevatedButton(
                          onPressed: () => _authController.resetPassword(context),
                          child: const Text(AppMessages.resetPasswordButton),
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
