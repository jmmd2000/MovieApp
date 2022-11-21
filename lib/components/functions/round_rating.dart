// This recursive function is used to round some of the values of the ratings as
// the default rounding methods in dart are not what I am looking for. It takes in
// the rating string, converts it to a double and checks if it has a decimal other than
// ".0". If it does, it removes it to leave it with a single number i.e. "7" instead of "7.0".
// It needs to be recursive as if we encounter the case "7.01" it would remove the "1" and leave it
// as "7.0", so in that case it should be sent through again to tidy it further.
import 'dart:math';

String roundRating(rating, count) {
  if (rating != "N/A") {
    double convertedRating = double.parse(rating);
    if (count <= 1) {
      String finalRating = "";
      if (convertedRating == convertedRating.roundToDouble()) {
        finalRating = rating.replaceAll(".0", "");
      } else {
        finalRating =
            ((convertedRating * pow(10, 1)).truncate() / pow(10, 1)).toString();
      }
      count++;
      return roundRating(finalRating, count);
    } else if (count >= 2) {
      count = 0;
      return rating;
    }
    return "error";
  } else {
    return "N/A";
  }
}
