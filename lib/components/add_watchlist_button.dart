// This button manages the watchlist state of a movie. It gets swapped with RemoveWatchlistButton
// depending on if the movie is already added and just toggles a movies addition to
// the watchlist.

import 'package:api/components/movie/movie_thumb.dart';
import 'package:flutter/material.dart';
import 'package:api/colours.dart';
import 'package:api/main.dart';
import 'functions/db.dart';
import 'functions/movie.dart';

class AddWatchlistButton extends StatelessWidget {
  final Movie movie;
  final Function onSwap;

  const AddWatchlistButton({
    super.key,
    required this.movie,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: (() async {
          bool success = await addtoWatchlist(movie);
          if (success = true) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 1),
              content: Row(children: const [
                Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('Added to watchlist'),
                )
              ]),
              backgroundColor: secondaryColour,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            watchList.add(MovieThumb(
              movie: movie,
            ));
          } else {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 1),
              content: Row(children: const [
                Icon(
                  Icons.error_outline,
                  color: Colors.orange,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('Error adding to watchlist'),
                )
              ]),
              backgroundColor: primaryColour,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          onSwap();
        }),
        tooltip: 'Add to Watchlist',
        heroTag: "watchlistAddButton",
        child: const Icon(Icons.playlist_add));
  }
}
