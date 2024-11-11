import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants/app_messages.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.loginPageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                _authController.email.value = value;
                if (!GetUtils.isEmail(value)) {
                  _authController.showError(AppMessages.invalidEmail);
                }
              },
              decoration: const InputDecoration(labelText: AppMessages.emailLabel),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => _authController.password.value = value,
              decoration: const InputDecoration(labelText: AppMessages.passwordLabel),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Obx(() => _authController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (GetUtils.isEmail(_authController.email.value)) {
                        _authController.login();
                      } else {
                        _authController.showError(AppMessages.invalidEmail);
                      }
                    },
                    child: const Text(AppMessages.loginButton),
                  )),
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
    );
  }
}
