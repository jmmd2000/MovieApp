import 'package:flutter/material.dart';
import '../../pages/movie_page.dart';
import '../../colours.dart';
import '../functions/round_rating.dart';
import '../functions/get_image.dart';
import 'dart:core';

class MovieThumb extends StatefulWidget {
  final String posterPath;
  final String rating;
  final String movieId;
  const MovieThumb({super.key, required this.posterPath, required this.rating, required this.movieId});

  @override
  State<MovieThumb> createState() => _MovieThumbState();
}

class _MovieThumbState extends State<MovieThumb> {
  late double ratingRounded = double.parse(widget.rating);
  String ratingString = "";
  _MovieThumbState();

  @override
  Widget build(BuildContext context) {
    ratingString = widget.rating.toString();
    int count = 0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MoviePage(
                    api: 'https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US',
                    reviewsAPI: 'https://api.themoviedb.org/3/movie/${widget.movieId}/reviews?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1',
                    movieID: widget.movieId,
                  )),
        );
      },
      child: Center(
        child: Stack(children: [
          getMovieThumbImage(widget.posterPath),
          // Image.network(
          //   'https://image.tmdb.org/t/p/w500${widget.posterPath}',
          //   height: 172,
          //   width: 121,
          //   fit: BoxFit.cover,
          // ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
              decoration: BoxDecoration(color: secondaryColour.withOpacity(0.9)),
              child: Text(
                (roundRating(widget.rating, count)),
                style: const TextStyle(fontSize: 12, color: fontPrimary),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
