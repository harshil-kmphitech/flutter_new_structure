# Retrofit - Injectable - GetIt

### Dependencies:

To inject all the required packages in the project, run the following command:

```
flutter pub add dio dio_smart_retry injectable retrofit json_annotation get_it path_provider shared_preferences
```

Or inject Dev dependencies:

```
flutter pub add retrofit_generator build_runner json_serializable injectable_generator --dev
```

After all dependencies implemented check the dependencies in pubspec.yaml

For generate all the generative code run the following command in the project terminal:

```
flutter pub run build_runner build
```

## Get_it with Injectable:

Get_it is an resource locator that helps you to manage different module and easy to access anywhere. and the [Injectable](https://pub.dev/packages/injectable) helps to boost the [Get_it](https://pub.dev/packages/get_it) initialization.

## Injectable:
#### Method:
**InjectableInit:** Must declare this method. and use `FileName.config.dart` [Check here](https://github.com/harshil-kmphitech/demo/blob/main/lib/app/utils/helpers/injectable/injectable.dart) for auto generate the initialization code.

Must use configuration function in main function and pass runApp in parameter.

``` dart
@i.injectableInit
Future<void> configuration({required void Function() runApp}) async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await getIt.init();
      getIt<Class Name here>(); // To access resource
      runApp();
    },
    zoneSpecification: ZoneSpecification(
      handleUncaughtError: (Zone zone, ZoneDelegate delegate, Zone parent, Object error, StackTrace stackTrace) {
        // Add Crashlytics here.
      },
    ),
  );
}
```
**lazySingleton:** It's a lazy singleton, which means the instance won't be created until it's first needed. This helps optimize performance by avoiding unnecessary object creation.

**singleton:** Meaning only one instance of it will exist throughout the application's lifecycle

**injectable:** Indicating that it can be injected into other classes using the Injectable framework

**factoryMethod:**
```dart
@i.lazySingleton
@i.injectable
abstract class AuthRetro {
  @i.factoryMethod
   factory AuthRetro(Dio dio) = _AuthRetro;
}
```

This is the actual use of factoryMethod. and make sure that this method need Dio as arguments so use must have to use @singleton for Dio. check out in module example.

**module:**
```dart
@module
abstract class RegisterModule {
  @singleton
  Dio dio() => Dio();

  @preResolve
  Future<Directory> temporaryDirectory() => getTemporaryDirectory();

  @preResolve
  Future<FirebaseApp> initializeFireBase() => Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
}
```

**Named:** Used for define same Type of Object with different name.
```dart
@module
abstract class RegisterModule {
  @preResolve
  @Named('temporary')
  Future<Directory> temporaryDirectory() => getTemporaryDirectory();

  @preResolve
  @Named('document')
  Future<Directory> documentDirectory() => getApplicationDocumentsDirectory();
}
```

Access:
```dart
getIt<Directory>(instanceName: 'temporary');
getIt<Directory>(instanceName: 'document');
```

**Warning**: The `instanceName` parameter is mandatory. Failure to provide it will cause a runtime exception.


## Retrofit:

Let's explore the [auth_service.dart](https://github.com/harshil-kmphitech/demo/blob/main/lib/app/data/services/authService/auth_service.dart) file in this Flutter project. This file likely defines an API service using Retrofit for authentication purposes. We'll analyze its structure and how it interacts with the backend API endpoints.

#### Module Declaration:

```dart
@RestApi(parser: Parser.FlutterCompute, baseUrl: 'https:/localhost:8080/')
@i.lazySingleton
@i.injectable
abstract class AuthRetro {
  @i.factoryMethod
  factory AuthRetro(Dio dio) = _AuthRetro;
}
```

#### Method Usage:
```dart
@POST('/login')
Future<AuthModel?> login(
    @Query('email') String email,
    @Query('password') String password,
);
```

There many more methods available in [Retrofit](https://pub.dev/packages/retrofit) for Server communication like PUT, DELETE, PATCH, HEAD etc...
For upload Files with PART.

#### PART Usage:

If the API accepts form data, use the `@Part()` decorator.

```dart
@POST('/uploadProfile')
@MultiPart()
Future<CommonResModel> uploadProfile({
    @Part(name: "profile_image", contentType: 'image/png') required File image,
});
```

As a last step, please review the automated [token interceptor](https://github.com/harshil-kmphitech/demo/blob/main/lib/app/utils/helpers/Interceptor/token_interceptor.dart).

## Json Serialization:

Use advanced json to Data Modal conversion. use [json_serializable](https://pub.dev/packages/json_serializable) package.

#### Usage:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

AuthModel deserializeAuthModel(Map<String, dynamic> json) => AuthModel.fromJson(json);

@JsonSerializable()
class AuthModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  @JsonKey(fromJson: _convertToEncrypted)
  final String? password;
  final String? phoneNumber;
  final String? profileImage;

  AuthModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.profileImage,
  });

  // Factory method to create an AuthModel from JSON
  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  // Method to convert an AuthModel instance to JSON
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  static String _convertToEncrypted(String value) {
    // Write logic here to custom use of Json response here.
    return value;
  }
}
```

For more info about packages head to [Pub.dev](https://pub.dev/):
[Retrofit](https://pub.dev/packages/retrofit), 
[Injectable](https://pub.dev/packages/injectable), 
[Get_it](https://pub.dev/packages/get_it), 
[Json Serialization](https://pub.dev/packages/json_serializable), 

For more help: contact to Jay Padsala