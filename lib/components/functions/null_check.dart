String nullCheck(string) {
  string = string.toString();
  // print("The string is = " + string);
  if (string == "null") {
    return "N/A";
  } else if (string.length == 0) {
    // print("3string = " + string);
    return "N/A";
  } else if (string == null) {
    // print("2string = " + string);
    return "N/A";
  } else {
    // print("1string = " + string);
    return string;
  }
}

// This function is specifically for checking if the 'production_companies' array is empty
String arrayCheckCountryOrigin(array) {
  // print(array);
  if (array.length != 0) {
    String temp = array[0]['origin_country'];
    if (temp == "null") {
      return "N/A";
    } else if (temp == "") {
      return "N/A";
    } else if (temp.isEmpty) {
      return "N./A";
    } else {
      return temp;
    }
  } else {
    return "N/A";
  }
}
