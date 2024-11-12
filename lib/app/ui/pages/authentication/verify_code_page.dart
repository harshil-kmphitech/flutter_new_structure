import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/app_messages.dart';
import '../../../utils/helpers/injectable/injectable.dart';

class VerifyCodePage extends StatelessWidget {
  final AuthController _authController = getIt<AuthController>();

  VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppMessages.verifyCodePageTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _authController.verificationCode,
                decoration: const InputDecoration(labelText: AppMessages.codeLabel),
                keyboardType: TextInputType.number,
                validator: AppValidations.verificationCodeValidation,
              ),
              Obx(
                () => _authController.verificationState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(builder: (context) {
                        return ElevatedButton(
                          onPressed: () => _authController.verifyCode(context),
                          child: const Text(AppMessages.verifyButton),
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
