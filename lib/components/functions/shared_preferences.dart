import 'package:api/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> fetchSearchHistory() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String>? history = prefs.getStringList("history") ?? [];
  return history;
}

void saveToSearchHistory(query, callback) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (searchHistory.contains(query)) {
  } else {
    if (searchHistory.length == 5) {
      searchHistory.removeAt(searchHistory.length - 1);
      searchHistory.insert(0, query);
      prefs.setStringList("history", searchHistory);
    } else {
      searchHistory.insert(0, query);
      prefs.setStringList("history", searchHistory);
    }
  }
  callback();
}

void removeFromSearchHistory(query, callback) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  searchHistory.remove(query);
  prefs.setStringList("history", searchHistory);
  callback();
}
