String nullCheck(string) {
  if (string == "null") {
    // print("3string = " + string);
    return "N/A";
  } else if (string.length == 0) {
    // print("2string = " + string);
    return "N/A";
  } else {
    // print("1string = " + string);
    return string;
  }
}
