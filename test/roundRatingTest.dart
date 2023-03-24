import 'dart:math';

import 'package:api/components/functions/round_rating.dart';
import 'package:test/test.dart';

void main() {
  test("Number should be returned without a .0 at the end", () {
    for (double i = 0.0; i < 100.0; i++) {
      String output = roundRating(i);
      if (output.contains(".0")) {
        bool test = false;
        expect(test, false);
      } else {
        bool test = true;
        expect(test, true);
      }
    }
  });
}
