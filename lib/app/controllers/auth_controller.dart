import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_new_structure/app/data/services/authService/auth_service.dart';
import 'package:flutter_new_structure/app/ui/widgets/custom_snack_bar.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/injectable/injectable.dart';
import 'package:flutter_new_structure/app/utils/helpers/loading.dart';
import 'package:flutter_new_structure/app/utils/helpers/logger.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart' as i;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  Future<void> onContinueWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
    );

    Loading.show();
    GoogleSignInAccount? authData;
    try {
      await googleSignIn.signOut();
      authData = await googleSignIn.signInSilently();
      authData ??= await googleSignIn.signIn();
    } catch (e) {
      e.log;
      Loading.dismiss();
    }

    if (authData == null) {
      Loading.dismiss();
      return;
    }

    authData;

    await getIt<AuthService>()
        .isRegister(
      email: authData.email,
      name: authData.displayName ?? '',
      // deviceToken: 'No found',
      // deviceType: switch (Platform.operatingSystem) {
      //   'ios' => 'iOS',
      //   'android' => 'android',
      //   _ => 'Other',
      // },
      isSocialType: 'google',
      // googleId: authData.id,
    )
        .handler(
      null,
      onSuccess: (value) {
        googleSignIn.signOut();
        value.showToast();
      },
      onFailed: (value) {
        value.showToast();
      },
    );
  }

  Future<void> onContinueWithApple() async {
    signInWIthAppleAvailable ??= await SignInWithApple.isAvailable();
    if (signInWIthAppleAvailable == null || !signInWIthAppleAvailable!) {
      return;
    }
    try {
      final authData = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.kmtemp.social.login.service',
          redirectUri: Uri.parse(
            'https://flutterfire-23423.firebaseapp.com/__/auth/handler',
          ),
        ),
        nonce: sha256ofString(_generateNonce()),
        state: 'Success',
      );

      authData.log;
    } on SignInWithAppleAuthorizationException catch (e) {
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
          Get.showSnackbar(
            AppSnackBar(message: e.message),
          );
        case AuthorizationErrorCode.failed:
          Get.showSnackbar(
            AppSnackBar(message: e.message),
          );
        case AuthorizationErrorCode.invalidResponse ||
              AuthorizationErrorCode.notHandled ||
              AuthorizationErrorCode.notInteractive ||
              AuthorizationErrorCode.unknown ||
              AuthorizationErrorCode.credentialExport ||
              AuthorizationErrorCode.credentialImport ||
              AuthorizationErrorCode.matchedExcludedCredential:
          Get.showSnackbar(
            AppSnackBar(message: e.message),
          );
      }
    }
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool? signInWIthAppleAvailable;
}
