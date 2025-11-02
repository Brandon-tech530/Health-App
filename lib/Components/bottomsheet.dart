import 'package:flutter/material.dart';

/// A reusable BottomSheet builder.
/// Call it with `showCustomBottomSheet(context, title: "...", body: "...")`
Future<void> showCustomBottomSheet(
  BuildContext context, {
  required String title,
  required Widget body,
  String buttonText = "Close",
  VoidCallback? onButtonPressed,
}) {
  final theme = Theme.of(context);

  return showModalBottomSheet(
    context: context,
    isScrollControlled: false, // Allows full-screen expansion if needed
    backgroundColor: Colors.grey[300],
    anchorPoint: Offset.fromDirection(1.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                )
              ],
            ),
            const SizedBox(height: 12),

            // Custom body content
            body,

            const SizedBox(height: 20),

            // Bottom button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onButtonPressed ?? () => Navigator.pop(ctx),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      );
    },
  );
}
