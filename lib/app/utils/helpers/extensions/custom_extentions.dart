import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizedBoxExtension on num {
  // Width sized box
  SizedBox get widthBox => SizedBox(width: toDouble().w);

  // Height sized box
  SizedBox get heightBox => SizedBox(height: toDouble().h);
}

extension AlignmentExtension on Widget {
  // Align the widget to the top left
  Widget get alignTopLeft => Align(
        alignment: Alignment.topLeft,
        child: this,
      );

  // Align the widget to the top center
  Widget get alignTopCenter => Align(
        alignment: Alignment.topCenter,
        child: this,
      );

  // Align the widget to the top right
  Widget get alignTopRight => Align(
        alignment: Alignment.topRight,
        child: this,
      );

  // Align the widget to the center left
  Widget get alignCenterLeft => Align(
        alignment: Alignment.centerLeft,
        child: this,
      );

  // Align the widget to the center
  Widget get alignCenter => Align(
        child: this,
      );

  // Align the widget to the center right
  Widget get alignCenterRight => Align(
        alignment: Alignment.centerRight,
        child: this,
      );

  // Align the widget to the bottom left
  Widget get alignBottomLeft => Align(
        alignment: Alignment.bottomLeft,
        child: this,
      );

  // Align the widget to the bottom center
  Widget get alignBottomCenter => Align(
        alignment: Alignment.bottomCenter,
        child: this,
      );

  // Align the widget to the bottom right
  Widget get alignBottomRight => Align(
        alignment: Alignment.bottomRight,
        child: this,
      );
}

extension GestureExtension on Widget {
  Widget withGestures({
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureDragUpdateCallback? onPanUpdate,
    GestureScaleUpdateCallback? onScaleUpdate,
  }) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onPanUpdate: onPanUpdate,
      onScaleUpdate: onScaleUpdate,
      child: this, // Wrap the original widget
    );
  }
}
