import 'package:flutter_new_structure/app/data/providers/auth_provider.dart';
import 'package:flutter_new_structure/app/data/repositories/auth_repository.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily inject the AuthController whenever required
    Get.lazyPut<AuthController>(() => AuthController());

    // Injecting the repository and provider dependencies for AuthRepository
    Get.lazyPut<AuthRepository>(() => AuthRepository());

    // Injecting the AuthProvider which interacts with API
    Get.lazyPut<AuthProvider>(() => AuthProvider());
  }
}
