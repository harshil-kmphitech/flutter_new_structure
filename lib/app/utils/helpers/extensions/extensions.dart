import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesX on SharedPreferences {
  String? get getToken {
    return getString('token');
  }

  set setToken(String? value) {
    if (value == null) {
      remove('token');
    } else {
      setString('token', value);
    }
  }
}

extension StringX on String {
  String get convertMd5 => md5.convert(utf8.encode(this)).toString();
}
