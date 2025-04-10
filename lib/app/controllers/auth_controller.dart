import 'package:get/get.dart';
import 'package:injectable/injectable.dart' as i;

@i.lazySingleton
class AuthController extends GetxController {
  AuthController() {
    onInit();
  }

  @override
  @i.disposeMethod
  void dispose() {
    super.dispose();
  }
}
