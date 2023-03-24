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
