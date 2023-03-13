// This code checks if a string is null
bool nullCheck(string) {
  string = string.toString();
  if (string == "null") {
    return false;
  } else if (string.length == 0) {
    return false;
  } else if (string == null) {
    return false;
  } else {
    return true;
  }
}

// This function is specifically for checking if the 'production_companies' array is empty
String arrayCheckCountryOrigin(array) {
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
