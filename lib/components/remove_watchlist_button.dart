import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../colours.dart';
import 'functions/db.dart';

class RemoveWatchlistButton extends StatelessWidget {
  final String movieID;
  final Function onSwap;
  final String posterPath;

  const RemoveWatchlistButton({super.key, required this.movieID, required this.onSwap, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (() {
        bool success = deleteFromWatchlist(movieID);
        if (success = true) {
          final snackBar = SnackBar(
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
            // action: SnackBarAction(
            //   label: 'Undo',
            //   textColor: Colors.white,
            //   onPressed: () {
            //     addtoWatchlist(posterPath, movieID);
            //   },
            // ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
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
      child: Icon(Icons.playlist_remove),
      backgroundColor: Colors.red,
    );
  }
}
