import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectmercury/pages/storePage/store_data.dart';

var formatCurrency = NumberFormat.simpleCurrency();
var formatDate = DateFormat('yMMMMd');

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}

// format time in HH:mm:ss format
String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours) != '00' ? '${twoDigits(duration.inHours)}:' : ''}$twoDigitMinutes:$twoDigitSeconds";
}

bool isItemName(String string) {
  return storeItems.where((element) => element.item == string).isNotEmpty;
}

// shows pop-up with yes/no options. Returns true if 'yes' selected; else false.
Future<bool?> showConfirmation({
  required BuildContext context,
  String? title,
  String? text,
  bool static = false,
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
        if (static == false) ...[
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
        ] else ...[
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text(
              'ok',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ],
    ),
  );
  return result;
}

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }
  return string[0].toUpperCase() + string.substring(1);
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

BoxDecoration elevatedCardDecor(BuildContext context, {Color? color}) {
  return BoxDecoration(
    color: color ?? Theme.of(context).colorScheme.background,
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

Widget yesOrNo(
  BuildContext context, {
  required String yesLabel,
  required String noLabel,
  String confirmationTitle = 'Confirmation',
  required String yesConfirmationMessage,
  required String noConfirmationMessage,
  required Function() onYes,
  required Function() onNo,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton.icon(
        onPressed: () async {
          bool result = await showConfirmation(
                context: context,
                title: confirmationTitle,
                text: noConfirmationMessage,
              ) ??
              false;
          if (result == true) {
            onNo();
          }
        },
        icon: const Icon(Icons.close, size: 32),
        label: Text(
          noLabel,
          style: const TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.red[700],
        ),
      ),
      ElevatedButton.icon(
        onPressed: () async {
          bool result = await showConfirmation(
                context: context,
                title: confirmationTitle,
                text: yesConfirmationMessage,
              ) ??
              false;
          if (result == true) {
            onYes();
          }
        },
        icon: const Icon(Icons.check, size: 36),
        label: Text(
          yesLabel,
          style: const TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green[700],
        ),
      ),
    ],
  );
}
