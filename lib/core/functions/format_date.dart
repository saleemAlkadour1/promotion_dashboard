import 'package:intl/intl.dart';

String formatDate(String date) {
  DateTime dateTime = DateTime.parse(date);

  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

  return formattedDate;
}
