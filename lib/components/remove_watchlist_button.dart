// This button manages the watchlist state of a movie. It gets swapped with AddWatchlistButton
// depending on if the movie is already added and just toggles a movies addition to
// the watchlist.

import 'package:api/components/functions/movie.dart';
import 'package:flutter/material.dart';
import 'package:api/components/functions/db.dart';

class RemoveWatchlistButton extends StatelessWidget {
  final Movie movie;
  final Function onSwap;

  const RemoveWatchlistButton({
    super.key,
    required this.movie,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (() async {
        bool success = await deleteFromWatchlist(movie.id);
        if (success = true) {
          final snackBar = SnackBar(
            duration: const Duration(seconds: 1),
            content: Row(children: const [
              Icon(
                Icons.close,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text('Removed from watchlist'),
              )
            ]),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            duration: const Duration(seconds: 1),
            content: Row(children: const [
              Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text('Error removing from watchlist'),
              )
            ]),
            backgroundColor: Colors.orange,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        onSwap();
      }),
      tooltip: 'Remove from watchlist',
      heroTag: "watchlistRemoveButton",
      backgroundColor: Colors.red,
      child: const Icon(Icons.playlist_remove),
    );
  }
}
