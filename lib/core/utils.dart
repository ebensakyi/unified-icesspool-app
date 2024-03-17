import 'package:intl/intl.dart';

class Utils {
  static String convertTime(originalDateString) {
    // Parse the original date string
    DateTime originalDate = DateTime.parse(originalDateString);

    // Format the date in the desired format
    String formattedDateTime =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(originalDate);

    return formattedDateTime;
  }
}
