part of 'custom_input_field.dart';

class PasswordController extends TextEditingController {
  RxBool obscureText = true.obs;

  @override
  void dispose() {
    obscureText.close();
    super.dispose();
  }
}
