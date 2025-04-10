import 'package:flutter_new_structure/app/data/services/authService/auth_service.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/exporter.dart';
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginPage extends StatelessWidget {
  const SocialLoginPage({super.key});

  static Future<T?>? offAllRoute<T>() {
    return Get.offAllNamed(AppRoutes.socialLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              color: const Color(0xFF1877F2),
              onPressed: _onFacebook,
              child: Row(
                spacing: 8,
                children: [
                  SizedBox.square(
                    dimension: 24,
                    child: Center(
                      child: SvgPicture.asset(AppIcons.facebook),
                    ),
                  ),
                  const Text(
                    'Continue with Facebook',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              color: Colors.white,
              onPressed: _onGoogle,
              child: Row(
                spacing: 8,
                children: [
                  SizedBox.square(
                    dimension: 24,
                    child: Center(
                      child: SvgPicture.asset(AppIcons.google),
                    ),
                  ),
                  Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.changeOpacity(.54),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              color: Colors.black,
              onPressed: _onApple,
              child: Row(
                spacing: 8,
                children: [
                  SizedBox.square(
                    dimension: 24,
                    child: Center(
                      child: SvgPicture.asset(AppIcons.apple),
                    ),
                  ),
                  const Text(
                    'Continue with Apple',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFacebook() {}

  Future<void> _onGoogle() async {
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

  void _onApple() {}
}

class AppIcons {
  static const facebook = 'assets/svg/facebook.svg';
  static const google = 'assets/svg/google.svg';
  static const apple = 'assets/svg/apple.svg';
}
