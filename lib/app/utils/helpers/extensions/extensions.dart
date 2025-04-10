import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
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

  String? get getUserId {
    return getString('UserId');
  }

  set setUserId(String? value) {
    if (value == null) {
      remove('UserId');
    } else {
      setString('UserId', value);
    }
  }

  String? get getAppLocal {
    return getString('appLocal');
  }

  set setAppLocal(String? value) {
    if (value == null) {
      remove('appLocal');
    } else {
      setString('appLocal', value);
    }
  }
}

extension StringX on String {
  String get convertMd5 => md5.convert(utf8.encode(this)).toString();
}

extension BuildContextX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension ColorX on Color {
  Color changeOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0,
        'Opacity must be between 0.0 and 1.0');
    return withAlpha((255.0 * opacity).round());
  }
}
