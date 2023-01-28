import 'package:api/components/functions/global.dart';
import 'package:api/components/movie/movie_thumb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../colours.dart';
import 'functions/db.dart';

class AddWatchlistButton extends StatelessWidget {
  final String movieID;
  final Function onSwap;
  final String posterPath;

  const AddWatchlistButton({super.key, required this.movieID, required this.onSwap, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: (() {
          bool success = addtoWatchlist(posterPath, movieID);
          if (success = true) {
            final snackBar = SnackBar(
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
              // action: SnackBarAction(
              //   label: 'Undo',
              //   textColor: Colors.white,
              //   onPressed: () {
              //     deleteFromWatchlist(movieID);
              //   },
              // ),
              backgroundColor: secondaryColour,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            resultList.add(MovieThumb(posterPath: posterPath, rating: "0", movieId: movieID));
          } else {
            final snackBar = SnackBar(
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
