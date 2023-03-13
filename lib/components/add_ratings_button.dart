// This button manages the add rating functionality. It displays as green and when tapped
// it brings up the rating modal. It gets swapped out for the ManageRatingsButton if the movie
// gets a rating or loses a rating

import 'package:api/colours.dart';
import 'package:api/components/functions/dialogs.dart';
import 'package:api/components/functions/movie.dart';
import 'package:flutter/material.dart';

class AddRatingsButton extends StatefulWidget {
  final BuildContext cntxt;
  final Movie movie;
  final Function onSwap;

  const AddRatingsButton({super.key, required this.cntxt, required this.movie, required this.onSwap});

  @override
  State<AddRatingsButton> createState() => _AddRatingsButtonState();
}

class _AddRatingsButtonState extends State<AddRatingsButton> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String rating = "";

  callback(value) {
    setState(() {
      rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: (() {
          Map success = ratingDialog(widget.cntxt, callback, widget.movie, true, widget.onSwap);

          switch (success["updateOrRate"]) {
            case 1:
              final snackBar = SnackBar(
                duration: const Duration(seconds: 1),
                content: Row(children: [
                  const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('Added to ratings with rating of ${success["rating"]}'),
                  )
                ]),
                backgroundColor: secondaryColour,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              break;
            case 2:
              final snackBar = SnackBar(
                duration: const Duration(seconds: 1),
                content: Row(children: [
                  const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('Updated rating to ${success["rating"]}'),
                  )
                ]),
                backgroundColor: secondaryColour,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              break;
            default:
          }
        }),
        tooltip: 'Add rating',
        heroTag: "ratingAddButton",
        child: const Icon(Icons.star));
  }
}
