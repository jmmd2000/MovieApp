import 'package:api/components/functions/null_check.dart';
import 'package:test/test.dart';

void main() {
  test("Should return null if string is null", () {
    var inputArray = ["apple", "banana", null, "pear", 0, 1];
    for (int i = 0; i < inputArray.length; i++) {
      bool test = nullCheck(inputArray[i]);
      if (inputArray[i] == null) {
        expect(test, false);
      } else {
        expect(test, true);
      }
    }
  });
}
