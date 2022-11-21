import 'dart:math';

int randomNumber(min, max) {
  int num = min + Random().nextInt(max - min);
  return num;
}
