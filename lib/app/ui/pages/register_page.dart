import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants/app_messages.dart';

class RegisterPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.registerPageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _authController.name.value = value,
              decoration: const InputDecoration(labelText: AppMessages.nameLabel),
            ),
            TextField(
              onChanged: (value) {
                _authController.email.value = value;
                if (!GetUtils.isEmail(value)) {
                  _authController.showError(AppMessages.invalidEmail);
                }
              },
              decoration: const InputDecoration(labelText: AppMessages.emailLabel),
            ),
            TextField(
              onChanged: (value) => _authController.password.value = value,
              decoration: const InputDecoration(labelText: AppMessages.passwordLabel),
              obscureText: true,
            ),
            TextField(
              onChanged: (value) => _authController.phoneNumber.value = value,
              decoration: const InputDecoration(labelText: AppMessages.phoneNumberLabel),
              keyboardType: TextInputType.phone,
            ),
            Obx(() => _authController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (GetUtils.isEmail(_authController.email.value)) {
                        _authController.register();
                      } else {
                        _authController.showError(AppMessages.invalidEmail);
                      }
                    },
                    child: const Text(AppMessages.registerButton),
                  )),
          ],
        ),
      ),
    );
  }
}
