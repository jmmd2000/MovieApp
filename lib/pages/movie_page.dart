// This component is a page that displays information about a particular movie.
// It displays the banner image for the movie, along with other information like:
// • Title                • Tagline             • Overview
// • Community rating     • List of genres      • Release Date
// • Runtime
// Along with a single, random user review in a CommentCard. There is also a button that
// brings the user to the CommentList page for the movie.

import 'dart:convert';
import 'package:api/components/functions/check_if_rated.dart';
import 'package:api/components/functions/movie.dart';
import 'package:api/components/functions/movie_page_section.dart';
import 'package:api/components/functions/round_rating.dart';
import 'package:api/components/functions/random_number.dart';
import 'package:api/components/movie/cast_slider.dart';
import 'package:api/components/movie/movie_slider.dart';
import 'package:api/main.dart';
import 'package:api/pages/discover_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api/colours.dart';
import 'package:api/components/comment/comment_card.dart';
import 'package:api/components/comment/comment_list.dart';
import 'package:api/components/functions/get_image.dart';
import 'package:api/components/fab.dart';
import 'package:api/pages/saved_page.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;
  final String? previousRoute;
  const MoviePage({
    super.key,
    required this.movie,
    this.previousRoute,
  });

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late Future<String> futureMovie;
  late Future<String> futureReviews;
  late Future<String> futureCast;
  late String director = "";
  late bool hasUserRating = (checkIfRated(widget.movie.id!.toString(), ratingsList) != "");
  late bool hasCast;
  late bool hasReviews;
  bool discoverPrevious = false;
  IconButton backButton = const IconButton(onPressed: null, icon: Icon(Icons.star));
  Map reviewMap = {};

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovie(widget.movie.id);
    futureCast = fetchCast(widget.movie.id);
    futureReviews = fetchReviews(widget.movie.id);
    hasCast = false;
    hasReviews = false;
    // discoverPrevious = checkPreviousRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        // leading: backButton,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: FutureBuilder<String>(
          future: futureMovie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map furtherMovieDetails = json.decode(snapshot.data!);
              return ListView(
                padding: const EdgeInsets.only(top: 0),
                children: [
                  Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(0, 255, 255, 255)],
                          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: getMovieImage(widget.movie.backdropPath),
                      ),
                      MoviePageSection(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Center(
                                  child: Column(
                                    children: [
                                      // Row that holds movie title, adult boolean and status string
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Text(
                                                furtherMovieDetails['title']!,
                                                softWrap: true,
                                                style: textPrimaryBold24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              widget.movie.releaseDate!.substring(0, 4),
                                              style: textSecondary16,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "${furtherMovieDetails['runtime']} mins",
                                              style: textSecondary16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(7),
                                            child: Text(
                                              "DIRECTED BY",
                                              style: textSecondary14,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(7),
                                              child: Text(
                                                director,
                                                style: textSecondaryBold14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.2, color: fontPrimary),
                                        ),
                                        child: getMovieThumbImage(widget.movie.posterPath),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      MoviePageSection(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              furtherMovieDetails['tagline'],
                              style: textPrimary14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              widget.movie.overview!,
                              style: textPrimary14,
                            ),
                          ),
                        ],
                      ),
                      MoviePageSection(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: secondaryColour,
                                      radius: 35,
                                      child: Text(
                                        roundRating(double.parse(widget.movie.voteAverage!)),
                                        style: textPrimaryBold28,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "${widget.movie.voteCount!} votes",
                                        style: textPrimaryBold18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              hasUserRating ? userRating() : const SizedBox.shrink(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 75.0,
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                    itemCount: furtherMovieDetails['genres'].length,
                                    padding: const EdgeInsets.all(10),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext c, int i) {
                                      Map genre = furtherMovieDetails['genres'][i];
                                      return Container(
                                        margin: const EdgeInsets.only(left: 0, right: 5.0),
                                        child: Wrap(
                                          children: [
                                            Chip(
                                              elevation: 20,
                                              padding: const EdgeInsets.only(left: 8, right: 8),
                                              backgroundColor: secondaryColour,
                                              shadowColor: Colors.black,
                                              label: Text(
                                                genre['name'],
                                                style: textPrimary12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // If the given movie does not have any data for the cast, don't show the cast section
                      hasCast
                          ? MoviePageSection(
                              children: [
                                CastSlider(futureCast: futureCast, sliderTitle: "Cast"),
                              ],
                            )
                          : const SizedBox.shrink(),
                      // If the given movie does not have any data for the reviews, don't show the review section
                      hasReviews
                          ? MoviePageSection(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
                                      child: Text(
                                        "Reviews",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: secondaryColour,
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 2,
                                ),
                                FutureBuilder<String>(
                                  future: futureReviews,
                                  builder: (context, reviewSnapshot) {
                                    if (reviewSnapshot.hasData) {
                                      Map jsonMapReviews = json.decode(reviewSnapshot.data!);
                                      reviewMap = jsonMapReviews;
                                      if (jsonMapReviews['results'].length > 0) {
                                        int ranNum = randomNumber(0, jsonMapReviews['results'].length);

                                        return Column(
                                          children: [
                                            CommentCard(
                                              authorUsername: jsonMapReviews['results'][ranNum]['author_details']['username'],
                                              profilePicture: jsonMapReviews['results'][ranNum]['author_details']['avatar_path'],
                                              reviewContent: jsonMapReviews['results'][ranNum]['content'],
                                              reviewRating: jsonMapReviews['results'][ranNum]['author_details']['rating'].toString(),
                                              fullContent: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(18),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => CommentList(
                                                              id: widget.movie.id,
                                                            )),
                                                  );
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all<Color>(secondaryColour),
                                                ),
                                                child: const Text("See all user reviews"),
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(50),
                                          child: Text(
                                            "No reviews",
                                            style: textPrimaryBold18,
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }
                                    } else if (reviewSnapshot.hasError) {
                                      return Text('${reviewSnapshot.error}');
                                    }

                                    // By default, show a loading spinner, this is for the reviews section
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(40),
                                        child: CircularProgressIndicator(
                                          color: secondaryDarker,
                                          backgroundColor: secondaryColour,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  reviewMap.isNotEmpty
                      ? MoviePageSection(children: [
                          MovieSlider(
                            sliderTitle: "Similar Movies",
                            api: "https://api.themoviedb.org/3/movie/${widget.movie.id}/recommendations?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1",
                          )
                        ])
                      : const SizedBox.shrink(),
                ],
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: CircularProgressIndicator(
                  color: secondaryDarker,
                  backgroundColor: secondaryColour,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FabMenu(
        movie: widget.movie,
        watchList: watchList,
        ratingsList: ratingsList,
      ),
    );
  }

  Future<String> fetchMovie(int? id) async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/${id!}?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US"));

    if (response.statusCode == 200) {
      setState(() {});

      return response.body;
    } else {
      throw Exception('Failed to load movie information');
    }
  }

  Future<String> fetchReviews(int? id) async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/${id!}/reviews?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US"));
    Map reviews = json.decode(response.body);
    if (reviews['results'].isNotEmpty) {
      setState(() {
        hasReviews = true;
      });
      return response.body;
    } else {
      return response.body;
    }
  }

  Future<String> fetchCast(int? id) async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/${id!}/credits?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US"));
    if (response.statusCode == 200) {
      Map castData = json.decode(response.body);
      if (castData.isNotEmpty) {
        setState(() {
          hasCast = true;
        });
      }
      for (int i = 0; i < castData['crew'].length; i++) {
        if (castData['crew'][i]['job'] == "Director") {
          setState(() {
            director = castData['crew'][i]['name'];
          });
        }
      }

      return response.body;
    } else {
      throw Exception('Failed to load cast');
    }
  }

  Widget userRating() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: secondaryColour,
            child: CircleAvatar(
              backgroundColor: bodyBackground,
              radius: 30,
              child: Text(
                roundRating(widget.movie.userRating!),
                style: textPrimaryBold28,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Your rating",
              style: textPrimaryBold18,
            ),
          )
        ],
      ),
    );
  }

  // bool checkPreviousRoute() {
  //   if (widget.previousRoute == "Discover") {
  //     setState(() {
  //       backButton = IconButton(
  //         icon: const Icon(Icons.arrow_back),
  //         onPressed: () => Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const DiscoverPage(),
  //           ),
  //         ).then((value) async => {}),
  //       );
  //     });
  //     return false;
  //   } else if (widget.previousRoute == "Watchlist") {
  //     setState(() {
  //       backButton = IconButton(
  //           icon: const Icon(Icons.car_crash),
  //           onPressed: () => Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => const SavedPage(),
  //                 ),
  //               ));
  //     });
  //     return false;
  //   } else {
  //     setState(() {
  //       backButton = IconButton(
  //         icon: const Icon(Icons.arrow_back),
  //         onPressed: () => Navigator.pop(context),
  //       );
  //     });
  //     return true;
  //   }
  // }
}
