import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

abstract class DefaultPath {
  Directory getTemporaryDirectory();
}

@lazySingleton
@injectable
class AppDirectory implements DefaultPath {
  final Directory temporaryDirectory;

  AppDirectory({required this.temporaryDirectory});

  @override
  Directory getTemporaryDirectory() => temporaryDirectory;
}

@module
abstract class RegisterModule {
  @singleton
  Dio dio() => Dio();

  @preResolve
  Future<Directory> temporaryDirectory() => getTemporaryDirectory();

  @preResolve
  Future<FirebaseApp> initializeFireBase() => Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform
      );
}
