import 'package:app/app/ui/widgets/custom_text.dart';
import 'package:app/app/utils/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.child,
    this.textStyle,
    this.type = AppButtonType.primary,
  }) : statesController = WidgetStatesController();

  final VoidCallback? onPressed;

  final String? title;

  final Widget? child;

  final AppButtonType type;

  final TextStyle? textStyle;

  final WidgetStatesController statesController;

  @override
  Widget build(BuildContext context) {
    final style = switch (type) {
      AppButtonType.primary => AppButtonThemes.of(context).primary,
    };

    var child = this.child;

    if (child == null && title != null) {
      child = CenterText(title!, style: null);
    }

    if (child != null) {
      if (textStyle != null) {
        child = DefaultTextStyle(style: textStyle!, child: child);
      }
      if (child is! DefaultTextStyle) {
        child = ListenableBuilder(
          listenable: statesController,
          builder: (context, child) {
            return DefaultTextStyle(
              style: style.textStyle?.resolve(statesController.value) ?? const Outfit(),
              child: child!,
            );
          },
          child: child,
        );
      }
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      statesController: statesController,
      child: child,
    );
  }
}
