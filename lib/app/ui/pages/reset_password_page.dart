import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants/app_messages.dart';

class ResetPasswordPage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.resetPasswordPageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _authController.password.value = value,
              decoration: const InputDecoration(labelText: AppMessages.newPasswordLabel),
              obscureText: true,
            ),
            TextField(
              onChanged: (value) => _authController.confirmPassword.value = value,
              decoration: const InputDecoration(labelText: AppMessages.confirmPasswordLabel),
              obscureText: true,
            ),
            Obx(() => _authController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _authController.resetPassword,
                    child: const Text(AppMessages.resetPasswordButton),
                  )),
          ],
        ),
      ),
    );
  }
}
