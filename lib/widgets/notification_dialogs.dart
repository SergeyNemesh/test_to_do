import 'package:flutter/material.dart';

Future<void> showNotificationDialog(
  BuildContext context,
  String notification,
  String message,
) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(notification),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                // Add your code here for the approve action
              },
            ),
          ],
        );
      });
}

Future<bool> showExitDialog(
  BuildContext context,
) async {
  bool result = false;
  result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Are you sure you want exit app?'),
              content: const Text('All user task will be removed!'),
              actions: [
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    // Add your code here for the approve action
                  },
                ),
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }) ??
      false;
  return result;
}
