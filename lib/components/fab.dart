// ignore_for_file: avoid_print

import 'package:api/components/add_watchlist_button.dart';
import 'package:api/components/functions/db.dart';
import 'package:api/components/movie/movie_thumb.dart';
import 'package:api/components/remove_watchlist_button.dart';
import '/components/functions/global.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:navbar_router/navbar_router.dart';
import 'package:api/colours.dart';
import '../pages/saved_page.dart';

class FabMenu extends StatefulWidget {
  // final Function() onPressed;
  final String movieID;
  final String posterPath;

  final List<MovieThumb> watchList;
  // final IconData icon;

  const FabMenu({
    super.key,
    required this.movieID,
    required this.posterPath,
    required this.watchList,
  });

  @override
  FabMenuState createState() => FabMenuState();
}

class FabMenuState extends State<FabMenu> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController animationController;
  late Animation<Color?> buttonColor;
  late Animation<double> animateIcon;
  late Animation<double> translateButton;
  final Curve curve = Curves.easeOut;
  final double fabHeight = 56.0;
  late Widget watchlistButton = Widget as Widget;
  // late bool showingAddWatchlistButton = checkIfAdded(widget.watchList, widget.movieID);
  bool showingAddWatchlistButton = false;

  @override
  initState() {
    showingAddWatchlistButton = !checkIfAdded(widget.watchList, widget.movieID);

    print(showingAddWatchlistButton);

    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    buttonColor = ColorTween(
      // begin: Colors.blue,
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

    // watchlistButton = watchlistButtonToggle(widget.watchList, widget.movieID, widget.posterPath);
    super.initState();
  }

  @override
  dispose() {
    animationController.dispose();
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

  // Widget watchlistButtonToggle(watchList, movieID, posterPath) {
  //   bool alreadyAdded = checkIfAdded(watchList, movieID);
  //   if (alreadyAdded) {
  //   } else {}
  // }

  Widget rate() {
    return FloatingActionButton(
      onPressed: (() => null),
      tooltip: 'Rate Movie',
      heroTag: "RateButton",
      child: Icon(Icons.thumbs_up_down),
    );
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
      // toggle the original widget state
      showingAddWatchlistButton = !showingAddWatchlistButton;
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
                  movieID: widget.movieID,
                  onSwap: toggleWatchlist,
                  posterPath: widget.posterPath,
                )
              : RemoveWatchlistButton(
                  movieID: widget.movieID,
                  onSwap: toggleWatchlist,
                  posterPath: widget.posterPath,
                ),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            translateButton.value,
            0.0,
          ),
          child: rate(),
        ),
        toggle(),
      ],
    );
  }
}

bool checkIfAdded(list, id) {
  print("check if added called");
  for (int i = 0; i < list.length; i++) {
    print("i = ${list[i].toString()}");
  }

  print(id);

  bool alreadyAdded = false;

  if (list.length == 0) {
    alreadyAdded = false;
    return alreadyAdded;
  }

  print("fab watchList.length= ${list.length}");
  list.forEach((element) {
    print("fab watchList.element= ${element.movieId}");
    if (element.movieId == id) {
      alreadyAdded = true;
    }
  });

  return alreadyAdded;
}
