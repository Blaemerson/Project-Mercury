import 'package:flutter/material.dart';

// shows pop-up with yes/no options. Returns true if 'yes' selected; else false.
Future<bool?> showConfirmation({
  required BuildContext context,
  String? title,
  String? text,
}) async {
  bool? result = false;
  result = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title != null
          ? Text(
              title,
              style: const TextStyle(fontSize: 24),
            )
          : null,
      content: text != null
          ? Text(
              text,
              style: const TextStyle(fontSize: 20),
            )
          : null,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text(
            'no',
            style: TextStyle(fontSize: 20),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(
            'yes',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    ),
  );
  return result;
}

// shows a snackbar with content message
void showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 1),
    ),
  );
}

BoxDecoration elevatedCardDecor(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).colorScheme.background,
    boxShadow: [
      BoxShadow(
        blurRadius: 5,
        color: Theme.of(context).colorScheme.onBackground,
        offset: const Offset(0, 2),
      ),
    ],
    borderRadius: BorderRadius.circular(8),
  );
}
