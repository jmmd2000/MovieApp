// This function checks the path to the profile picture for the user and checks it for a number of cases:
// The path could either be null, empty string, or a completely different URL. This checks each of those casese.
// If it is another URL or null or empty, it returns a default image in the assets folder. Otherwise, it returns the actual image.
import 'package:api/colours.dart';
import 'package:api/components/functions/random_number.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

ImageProvider getImage(path) {
  if (path.toString() != "null") {
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

Widget getMovieImage(path) {
  if (path != null) {
    if (path.length > 0) {
      if (path != "null") {
        return CachedNetworkImage(
          imageUrl: "https://image.tmdb.org/t/p/w1280/$path",
          errorWidget: (context, url, error) => Image.asset("lib/assets/errorBackdrop.png"),
        );
      } else {
        return Image.asset("lib/assets/errorBackdrop.png");
      }
    } else {
      return Image.asset("lib/assets/errorBackdrop.png");
    }
  } else {
    return Image.asset("lib/assets/errorBackdrop.png");
  }
}

Widget getMovieThumbImage(path) {
  Widget w = const SizedBox.shrink();
  switch (path) {
    case null:
      w = Image.asset(
        "lib/assets/errorThumb.png",
        height: 172,
        width: 121,
        fit: BoxFit.contain,
      );
      break;

    case "null":
      w = Image.asset(
        "lib/assets/errorThumb.png",
        height: 172,
        width: 121,
        fit: BoxFit.contain,
      );
      break;

    case "":
      w = Image.asset(
        "lib/assets/errorThumb.png",
        height: 172,
        width: 121,
        fit: BoxFit.contain,
      );
      break;

    default:
      w = CachedNetworkImage(
        placeholder: ((context, url) => Center(
              child: CircularProgressIndicator(
                color: secondaryDarker,
                backgroundColor: secondaryColour,
              ),
            )),
        imageUrl: "https://image.tmdb.org/t/p/w500$path",
        errorWidget: (context, url, error) => Image.asset(
          "lib/assets/errorThumb.png",
          height: 172,
          width: 121,
          fit: BoxFit.contain,
        ),
        height: 172,
        width: 121,
        fit: BoxFit.cover,
      );
  }

  return w;
}

Widget randomPlaceholderImage() {
  int r = randomNumber(0, 3);

  switch (r) {
    case 1:
      return Image.asset(
        "lib/assets/clacker.gif",
        height: 120,
        width: 120,
        fit: BoxFit.contain,
      );
    case 2:
      return Image.asset(
        "lib/assets/countdown.gif",
        height: 120,
        width: 120,
        fit: BoxFit.contain,
      );
    default:
      return Image.asset(
        "lib/assets/popcorn.gif",
        height: 120,
        width: 120,
        fit: BoxFit.contain,
      );
  }
}
