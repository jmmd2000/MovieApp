String nullCheck(string) {
  string = string.toString();
  print("The string is = " + string);
  if (string == "null") {
    return "N/A";
  } else if (string.length == 0) {
    // print("2string = " + string);
    return "N/A";
  } else {
    // print("1string = " + string);
    return string;
  }
}
