// This code generates a random number inside a specified range
import 'dart:math';

int randomNumber(min, max) {
  int num = min + Random().nextInt(max - min);
  return num;
}
