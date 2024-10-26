import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants/app_messages.dart';

class VerifyCodePage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.verifyCodePageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _authController.verificationCode.value = value,
              decoration: const InputDecoration(labelText: AppMessages.codeLabel),
              keyboardType: TextInputType.number,
            ),
            Obx(() => _authController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _authController.verifyCode,
                    child: const Text(AppMessages.verifyButton),
                  )),
          ],
        ),
      ),
    );
  }
}
