// This is the floating access button on the MoviePages. It contains
// the buttons to add to watchlist and add rating.

import 'package:api/components/add_ratings_button.dart';
import 'package:api/components/add_watchlist_button.dart';
import 'package:api/components/manage_ratings_button.dart';
import 'package:api/components/movie/movie_thumb.dart';
import 'package:api/components/remove_watchlist_button.dart';
import 'package:flutter/material.dart';
import 'package:api/colours.dart';
import 'functions/movie.dart';

class FabMenu extends StatefulWidget {
  final Movie movie;

  final List<MovieThumb> watchList;
  final List<MovieThumb> ratingsList;
  final Function updatePage;

  const FabMenu({
    super.key,
    required this.watchList,
    required this.ratingsList,
    required this.movie,
    required this.updatePage,
  });

  @override
  FabMenuState createState() => FabMenuState();
}

class FabMenuState extends State<FabMenu> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  bool isOpened = false;
  late AnimationController animationController;
  late Animation<Color?> buttonColor;
  late Animation<double> animateIcon;
  late Animation<double> translateButton;
  final Curve curve = Curves.easeOut;
  final double fabHeight = 56.0;
  late Widget watchlistButton = Widget as Widget;
  bool showingAddWatchlistButton = false;
  bool showingAddRatingsButton = false;
  String rating = "";

  @override
  initState() {
    showingAddWatchlistButton = !checkIfAdded(widget.watchList, widget.movie.id);
    showingAddRatingsButton = !checkIfAdded(widget.ratingsList, widget.movie.id);

    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    buttonColor = ColorTween(
      begin: secondaryColour,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    translateButton = Tween<double>(
      begin: fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: curve,
      ),
    ));

    super.initState();
  }

  @override
  dispose() {
    animationController.dispose();
    textController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: buttonColor.value,
      onPressed: animate,
      tooltip: 'Toggle',
      heroTag: "btn4",
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: animateIcon,
      ),
    );
  }

  toggleWatchlist() {
    setState(() {
      showingAddWatchlistButton = !showingAddWatchlistButton;
    });
  }

  toggleRatings() {
    setState(() {
      showingAddRatingsButton = !showingAddRatingsButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            translateButton.value * 2.0,
            0.0,
          ),
          child: showingAddWatchlistButton
              ? AddWatchlistButton(
                  movie: widget.movie,
                  onSwap: toggleWatchlist,
                )
              : RemoveWatchlistButton(
                  movie: widget.movie,
                  onSwap: toggleWatchlist,
                ),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            translateButton.value,
            0.0,
          ),
          child: showingAddRatingsButton
              ? AddRatingsButton(
                  movie: widget.movie,
                  onSwap: toggleRatings,
                  cntxt: context,
                  updatePage: widget.updatePage,
                )
              : ManageRatingsButton(
                  movie: widget.movie,
                  onSwap: toggleRatings,
                  cntxt: context,
                  updatePage: widget.updatePage,
                ),
        ),
        toggle(),
      ],
    );
  }

  bool checkIfAdded(list, id) {
    for (int i = 0; i < list.length; i++) {}

    bool alreadyAdded = false;

    if (list.length == 0) {
      alreadyAdded = false;
      return alreadyAdded;
    }

    list.forEach((element) {
      if (element.movie.id == id) {
        alreadyAdded = true;
      }
    });

    return alreadyAdded;
  }
}
