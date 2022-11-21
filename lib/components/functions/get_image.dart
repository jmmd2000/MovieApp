// This function checks the path to the profile picture for the user and checks it for a number of cases:
// The path could either be null, empty string, or a completely different URL. This checks each of those casese.
// If it is another URL or null or empty, it returns a default image in the assets folder. Otherwise, it returns the actual image.
import 'package:flutter/material.dart';

ImageProvider getImage(path) {
  if (path != null) {
    if (path.length > 0) {
      if (path.contains("://")) {
        return const AssetImage('lib/assets/default.png');
      } else {
        return NetworkImage('https://image.tmdb.org/t/p/w500$path');
      }
    } else {
      return const AssetImage('lib/assets/default.png');
    }
  } else {
    return const AssetImage('lib/assets/default.png');
  }
}
