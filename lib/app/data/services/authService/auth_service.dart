import 'package:app/app/global/app_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_service.g.dart';

@lazySingleton
@RestApi(baseUrl: AppConfig.baseUrl, parser: Parser.FlutterCompute)
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;
}
