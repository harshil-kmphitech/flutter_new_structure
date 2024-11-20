import 'package:flutter_new_structure/app/utils/helpers/all_imports.dart';

class AppText extends Text {
  const AppText(
    super.data, {
    super.key,
    required super.style,
    super.maxLines,
  });
}

class CenterText extends Text {
  const CenterText(
    super.data, {
    super.key,
    required super.style,
    super.textAlign = TextAlign.center,
    super.maxLines,
  });
}
