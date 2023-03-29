// This button gets swapped in for the AddRatingsButton. It displays as red with a different icon,
// and it brings up a different modal, prompting the user to either update or delete the rating.

import 'package:api/components/functions/dialogs.dart';
import 'package:api/components/functions/movie.dart';
import 'package:flutter/material.dart';

class ManageRatingsButton extends StatefulWidget {
  final BuildContext cntxt;
  final Movie movie;
  final Function onSwap;
  final Function updatePage;

  const ManageRatingsButton({super.key, required this.cntxt, required this.movie, required this.onSwap, required this.updatePage});

  @override
  State<ManageRatingsButton> createState() => _ManageRatingsButtonState();
}

class _ManageRatingsButtonState extends State<ManageRatingsButton> {
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
        optionDialog(widget.cntxt, callback, widget.movie, widget.onSwap, widget.updatePage);
      }),
      tooltip: 'Manage rating',
      heroTag: "ratingManageButton",
      backgroundColor: Colors.red,
      child: const Icon(Icons.star_border_outlined),
    );
  }
}
