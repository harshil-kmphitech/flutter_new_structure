import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/helpers/exception/exception.dart';
import '../../../utils/helpers/injectable/injectable.dart';
import '../../widgets/custom_textfields.dart';

class RegisterPage extends StatelessWidget {
  final AuthController _authController = getIt<AuthController>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var passObscure = true.obs;
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.T.register),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextInputField(
                type: InputType.name,
                controller: _authController.nameController,
                hintLabel: AppStrings.T.nameLabel,
                validator: AppValidations.nameValidation,
              ),
              const SizedBox(height: 16),
              TextInputField(
                type: InputType.email,
                controller: _authController.registerEmailController,
                hintLabel: AppStrings.T.emailLabel,
                validator: AppValidations.emailValidation,
              ),
              const SizedBox(height: 16),
              TextInputField(
                type: InputType.newPassword,
                controller: _authController.registerPassController,
                hintLabel: AppStrings.T.passwordLabel,
                obscureText: passObscure,
                validator: AppValidations.passwordValidation,
              ),
              const SizedBox(height: 16),
              TextInputField(
                type: InputType.phoneNumber,
                controller: _authController.phoneNumberController,
                hintLabel: AppStrings.T.phoneNumberLabel,
                validator: AppValidations.phoneNumberValidation,
              ),
              const SizedBox(height: 16),
              Obx(() => _authController.registerState.isLoading
                  ? const CircularProgressIndicator()
                  : Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () => _authController.sendOtp(context),
                          child: Text(AppStrings.T.register),
                        );
                      },
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
