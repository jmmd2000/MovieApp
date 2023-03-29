// This displays a movie poster and when tapped it brings the
// user to a MoviePage of the movie it displays. Once the user rates
// a movie, these will update with the rating.

import 'package:api/components/functions/check_if_rated.dart';
import 'package:flutter/material.dart';
import 'package:api/main.dart';
import 'package:api/pages/movie_page.dart';
import 'package:api/colours.dart';
import 'package:api/components/functions/movie.dart';
import 'package:api/components/functions/round_rating.dart';
import 'package:api/components/functions/get_image.dart';
import 'dart:core';

class MovieThumb extends StatefulWidget {
  final Movie movie;
  final String? previousRoute;
  final Function? callback;
  const MovieThumb({
    super.key,
    required this.movie,
    this.previousRoute,
    this.callback,
  });

  @override
  State<MovieThumb> createState() => _MovieThumbState();
}

class _MovieThumbState extends State<MovieThumb> {
  late double ratingRounded = double.parse(widget.movie.userRating!);
  String userRating = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userRating = checkIfRated(widget.movie.id, ratingsList);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviePage(
              movie: widget.movie,
              previousRoute: widget.previousRoute,
            ),
          ),
        );
      },
      child: Center(
        child: Stack(children: [
          getMovieThumbImage(widget.movie.posterPath),
          getRating(userRating) == true ? ratingBox(userRating) : const SizedBox.shrink(),
        ]),
      ),
    );
  }
}

bool getRating(rating) {
  bool b = false;

  if (rating.length > 0) {
    b = true;
  } else {
    b = false;
  }
  return b;
}

Widget ratingBox(rating) {
  double rating1 = double.parse(rating);
  return Positioned(
    top: 0,
    right: 0,
    child: Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
      decoration: BoxDecoration(color: secondaryColour.withOpacity(0.9)),
      child: Text(
        (roundRating(rating1)),
        style: const TextStyle(fontSize: 12, color: fontPrimary),
      ),
    ),
  );
}
