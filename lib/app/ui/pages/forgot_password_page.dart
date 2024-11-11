import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants/app_messages.dart';

class ForgotPasswordPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.forgotPasswordPageTitle),
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
            Obx(() => _authController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (GetUtils.isEmail(_authController.email.value)) {
                        _authController.forgotPassword();
                      } else {
                        _authController.showError(AppMessages.invalidEmail);
                      }
                    },
                    child: const Text(AppMessages.sendResetLinkButton),
                  )),
          ],
        ),
      ),
    );
  }
}
