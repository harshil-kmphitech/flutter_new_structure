import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/utils/helpers/exporter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppController {
  final _completer = Completer<bool>();

  Future<void> onSplash(BuildContext context) async {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (await _completer.future) {
          Get.offAllNamed(AppRoutes.login)?.ignore();
        }
      },
    );
    await _preCacheAssets(context).then(
      (value) => _completer.complete(true),
    );
  }

  Future<void> _preCacheAssets(BuildContext context) async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assets = manifest.listAssets();

    final listOfPng = assets.where((element) => element.endsWith('.png')).map((e) => precacheImage(AssetImage(e), context, onError: _onError));
    final listOfSvg = assets.where((element) => element.endsWith('.svg')).map(SvgAssetLoader.new);

    await Future.wait([
      ...listOfPng,
      ...listOfSvg.map((e) => e.loadBytes(context)),
    ]);

    if (context.mounted) {
      for (final e in listOfSvg) {
        e.cacheKey(context);
      }
    }
  }

  void _onError(Object exception, StackTrace? stackTrace) {
    if (kDebugMode) {
      exception.logWithName('precacheImageError');
    }
  }
}
