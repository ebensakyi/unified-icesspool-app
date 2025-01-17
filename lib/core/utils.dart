import 'dart:developer';

import 'package:flutter/material.dart';
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

  //  static int calculateHoursDifference() {
  //   var givenDateString = selectedDate.value.toString().split(" ")[0] +
  //       " " +
  //       formatTime(convertToTimeOfDay(selectedStartTime.value));

  //   // Splitting the given date string into date and time parts
  //   List<String> parts = givenDateString.split(" ");
  //   String datePart = parts[0];
  //   String timePart = parts[1];
  //   String period = parts[2];

  //   // Extracting year, month, and day
  //   List<String> dateParts = datePart.split("-");
  //   int year = int.parse(dateParts[0]);
  //   int month = int.parse(dateParts[1]);
  //   int day = int.parse(dateParts[2]);

  //   // Extracting hour and minute
  //   List<String> timeParts = timePart.split(":");
  //   int hour = int.parse(timeParts[0]);
  //   int minute = int.parse(timeParts[1]);

  //   // Converting hour to 24-hour format if necessary
  //   if (period == 'PM' && hour < 12) {
  //     hour += 12;
  //   } else if (period == 'AM' && hour == 12) {
  //     hour = 0;
  //   }

  //   // Create the DateTime object
  //   DateTime givenDateTime = DateTime(year, month, day, hour, minute);

  //   // Current datetime
  //   DateTime currentDateTime = DateTime.now();

  //   // Calculate the difference in hours
  //   int hoursDifference = currentDateTime.difference(givenDateTime).inHours;

  //   return hoursDifference.abs();
  // }

  static formatTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

  static TimeOfDay convertToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  static int calculateHoursDifference(
      DateTime selectedDate, String selectedStartTime) {
    var givenDateString = selectedDate.toString().split(" ")[0] +
        " " +
        formatTime(convertToTimeOfDay(selectedStartTime));

    // Splitting the given date string into date and time parts
    List<String> parts = givenDateString.split(" ");
    String datePart = parts[0];
    String timePart = parts[1];
    String period = parts[2];

    // Extracting year, month, and day
    List<String> dateParts = datePart.split("-");
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    // Extracting hour and minute
    List<String> timeParts = timePart.split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Converting hour to 24-hour format if necessary
    if (period == 'PM' && hour < 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    // Create the DateTime object
    DateTime givenDateTime = DateTime(year, month, day, hour, minute);

    // Current datetime
    DateTime currentDateTime = DateTime.now();

    // Calculate the difference in hours
    int hoursDifference = givenDateTime.difference(currentDateTime).inHours;

    inspect(hoursDifference);

    return hoursDifference;
  }
}
