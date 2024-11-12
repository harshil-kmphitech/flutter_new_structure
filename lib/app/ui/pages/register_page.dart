import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/constants/app_messages.dart';
import '../../utils/helpers/exeption/exeption.dart';
import '../../utils/helpers/injectable/injectable.dart';

class RegisterPage extends StatelessWidget {
  final AuthController _authController = getIt<AuthController>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppMessages.registerPageTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: AppMessages.nameLabel),
                controller: _authController.nameController,
                validator: AppValidations.nameValidation,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: AppMessages.emailLabel),
                controller: _authController.registerEmailController,
                validator: AppValidations.emailValidation,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: AppMessages.passwordLabel),
                obscureText: true,
                controller: _authController.registerPassController,
                validator: AppValidations.passwordValidation,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: AppMessages.phoneNumberLabel),
                keyboardType: TextInputType.phone,
                controller: _authController.phoneNumberController,
                validator: AppValidations.phoneNumberValidation,
              ),
              Obx(() => _authController.registerState.isLoading
                  ? const CircularProgressIndicator()
                  : Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          _authController.register(context);
                        },
                        child: const Text(AppMessages.registerButton),
                      );
                    })),
            ],
          ),
        ),
      ),
    );
  }
}
