import 'package:flutter_new_structure/app/controllers/app_controller.dart';
import 'package:flutter_new_structure/app/utils/helpers/exporter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        // TODO: Change you app Icon here, or custimize app splash
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void initState() {
    getIt<AppController>().onSplash(context);
    super.initState();
  }
}
