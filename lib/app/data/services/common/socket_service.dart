import 'package:demo/app/utils/helpers/injectable/injectable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class SocketService {
  void init() {
    //
    getIt.resetLazySingleton<SocketService>();
  }
}
