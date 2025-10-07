import 'package:flutter/widgets.dart';

class AppText extends Text {
  const AppText(super.data, {super.key, required super.style});
}

class CenterText extends Text {
  const CenterText(super.data, {super.key, required super.style})
    : super(textAlign: TextAlign.center);
}

class SingleLineText extends Text {
  const SingleLineText(
    super.data, {
    super.key,
    required super.style,
    super.textAlign,
    super.overflow = TextOverflow.ellipsis,
  }) : super(maxLines: 1);
}

class DoubleLineText extends Text {
  const DoubleLineText(
    super.data, {
    super.key,
    required super.style,
    super.textAlign,
    super.overflow = TextOverflow.ellipsis,
  }) : super(maxLines: 2);
}
