import 'package:intl/intl.dart';

String getDueText(DateTime dueDate) {
  final now = DateTime.now();
  final difference = dueDate.difference(now).inDays;

  // Pastikan tidak minus (kalau lewat hari)
  final daysRemaining = difference >= 0 ? difference : 0;

  return "Due in $daysRemaining days (${DateFormat('d MMM yyyy').format(dueDate)})";
}
