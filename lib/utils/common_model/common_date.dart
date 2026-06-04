import 'package:intl/intl.dart';

class CommonDate {

  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  static String formatDateFromString(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return formatDate(parsedDate);
    } catch (e) {
      throw FormatException("Invalid date string: $dateString");
    }
  }
}