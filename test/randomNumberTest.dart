import 'dart:math';

import 'package:api/components/functions/random_number.dart';
import 'package:test/test.dart';

void main() {
  test("Random number should be within the range", () {
    var ran = Random();
    for (int i = 0; i < 100; i++) {
      int ranNum = ran.nextInt(1000);
      int output = randomNumber(ranNum, ranNum *= 2);
      if ((ranNum *= 2) > output && output > ranNum) {
        bool x = true;
        expect(x, true);
      } else {
        bool x = false;
        expect(x, false);
      }
    }
  });
}
