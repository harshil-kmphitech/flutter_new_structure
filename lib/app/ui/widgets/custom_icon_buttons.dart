import 'package:app/app/ui/widgets/custom_image_view.dart';
import 'package:app/app/utils/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.type = AppIconButtonType.primary,
    this.dimension,
  }) : child = null;

  const AppIconButton.icon({
    super.key,
    required this.onPressed,
    required this.child,
    this.type = AppIconButtonType.primary,
    this.dimension,
  }) : icon = null;

  final Widget? child;

  final String? icon;

  final VoidCallback onPressed;

  final AppIconButtonType type;

  final double? dimension;

  @override
  Widget build(BuildContext context) {
    final style = switch (type) {
      AppIconButtonType.primary => AppIconButtonTheme.of(context).primary,
    };

    var imageView = child;

    ImageSize? inner;

    if (dimension != null) {
      inner = ImageSize(dimension: dimension);
    } else {
      final iconSize = style.iconSize as WidgetStatePropertyAll<double?>?;

      if (iconSize != null) {
        inner = ImageSize(dimension: iconSize.value);
      }
    }

    if (icon != null) {
      Color? color;
      if (style.iconColor case final WidgetStatePropertyAll<Color?> e) {
        color = e.value;
      }
      imageView = ImageView(icon, color: color, inner: inner);
    } else {
      imageView = SizedBox(
        height: inner?.dimension,
        child: FittedBox(child: child),
      );
    }

    return IconButton(onPressed: onPressed, style: style, icon: imageView);
  }
}
