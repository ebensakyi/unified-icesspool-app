import 'dart:developer';
import 'dart:math';

import 'package:intl/intl.dart';

int generateRandom() {
  Random rnd;
  int min = 5;
  int max = 10;
  rnd = new Random();
  int r = min + rnd.nextInt(max - min);
  return r;
}

String generateTransactionCode() {
  DateTime today = DateTime.now();
  String formattedDate = DateFormat('ddMMyy').format(today);

  final random = Random();
  StringBuffer codeBuffer = StringBuffer();

  // Ensure the first digit is not 0
  codeBuffer
      .write(random.nextInt(9) + 1); // Generates a random digit between 1 and 9

  // Generate the remaining 11 digits
  for (int i = 0; i < 4; i++) {
    codeBuffer.write(random.nextInt(9));
  }

  return formattedDate + codeBuffer.toString();
}

String generatePaymentCode(count) {
  Random random = Random();
  List<String> result = [];

  for (int i = 0; i < count; i++) {
    int randomNumber = random.nextInt(9000000000) +
        1000000000; // To ensure it doesn't start with 0
    result.add(randomNumber.toString());
  }

  return result.toString();
}
