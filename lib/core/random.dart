import 'dart:developer';
import 'dart:math';

int generateRandom() {
  Random rnd;
  int min = 5;
  int max = 10;
  rnd = new Random();
  int r = min + rnd.nextInt(max - min);
  inspect(r);
  return r;
}
