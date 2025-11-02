import 'package:flutter/material.dart';

/// A reusable Material 3 alert dialog.
/// - Title, message, and actions can be customized.
/// - Supports accessibility and safe dismissing.
class ReusableAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool dismissible;

  const ReusableAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    this.onConfirm,
    this.onCancel,
    this.dismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).maybePop();
            if (onCancel != null) onCancel!();
          },
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).maybePop();
            if (onConfirm != null) onConfirm!();
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}

/// Helper function to show the dialog easily.
Future<void> showReusableAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmText = "OK",
  String cancelText = "Cancel",
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool dismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (context) => ReusableAlertDialog(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      dismissible: dismissible,
    ),
  );
}
