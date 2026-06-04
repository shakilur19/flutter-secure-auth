import 'package:flutter/material.dart';

class CommonConfirmDialog {
  static Future<void> show({
    required BuildContext context,
    required String message,
    required VoidCallback onYes,
    String title = 'Confirm',
    String yesText = 'Yes',
    String noText = 'No',
    bool isDanger = false,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(noText),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDanger ? Colors.red : null,
              ),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(yesText),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      onYes();
    }
  }
}