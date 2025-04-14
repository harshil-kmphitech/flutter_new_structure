import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthController extends GetxController {
  AuthController() {
    onInit();
  }

  @override
  @disposeMethod
  void dispose() {
    super.dispose();
  }
}
