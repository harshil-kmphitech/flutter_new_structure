import 'package:flutter_new_structure/app/utils/helpers/exporter.dart';

class AppSnackBar extends GetSnackBar {
  const AppSnackBar({
    super.key,
    super.title,
    super.message,
  }) : super(
          icon: const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
          ),
          borderColor: Colors.redAccent,
          borderRadius: 10,
          padding: const EdgeInsets.all(12),
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.symmetric(horizontal: 16),
        );
}

