import 'package:flutter/material.dart';

class CustomSnackBars {
  static SnackBar success({
    required String message,
    Duration? duration,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green.shade600,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: duration ?? const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      dismissDirection: DismissDirection.horizontal,
      elevation: 4,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  static SnackBar error({
    required String message,
    Duration? duration,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red.shade600,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: duration ?? const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      dismissDirection: DismissDirection.horizontal,
      elevation: 4,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  static SnackBar info({
    required String message,
    Duration? duration,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue.shade600,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: duration ?? const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      dismissDirection: DismissDirection.horizontal,
      elevation: 4,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  static SnackBar warning({
    required String message,
    Duration? duration,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.orange.shade700,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: duration ?? const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      dismissDirection: DismissDirection.horizontal,
      elevation: 4,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  // Add this function to prevent multiple SnackBars
  static void showSnackBar(BuildContext context, SnackBar snackBar) {
    // Hide the current SnackBar (if any) before showing a new one
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // Show the new SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}