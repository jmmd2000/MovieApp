// This function is used to round some of the values of the ratings as
// the default rounding methods in dart are not what I am looking for. It takes in
// the rating string, converts it to a double and checks if it has a decimal other than
// ".0". If it does, it removes it to leave it with a single number i.e. "7" instead of "7.0"

String roundRating(var rating) {
  if (rating == "") {
    rating = 0.0;
  }
  double rounded = ((double.parse(rating.toString()) * 10).round()) / 10;
  String finalRating = rounded.toString().replaceAll(".0", "");
  return finalRating;
}
