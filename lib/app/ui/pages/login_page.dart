import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/exeption/exeption.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/constants/app_messages.dart';
import '../../utils/helpers/injectable/injectable.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = getIt<AuthController>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppMessages.loginPageTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _authController.emailController,
                decoration: const InputDecoration(labelText: AppMessages.emailLabel),
                keyboardType: TextInputType.emailAddress,
                validator: AppValidations.emailValidation,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _authController.passController,
                decoration: const InputDecoration(labelText: AppMessages.passwordLabel),
                obscureText: true,
                validator: AppValidations.passwordValidation,
              ),
              const SizedBox(height: 16),
              Obx(
                () => _authController.loginState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: () {
                              _authController.login(context);
                            },
                            child: const Text(AppMessages.loginButton),
                          );
                        },
                      ),
              ),
              TextButton(
                onPressed: () => Get.toNamed('/register'),
                child: const Text(AppMessages.registerRedirect),
              ),
              TextButton(
                onPressed: () => Get.toNamed('/forgot-password'),
                child: const Text(AppMessages.forgotPasswordRedirect),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
