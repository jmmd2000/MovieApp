// This component is a page that displays information about a particular movie.
// It displays the banner image for the movie, along with other information like:
// • Title                • Tagline             • Overview
// • Community rating     • List of genres      • Release Date
// • Runtime              • Budget              • Revenue
// • Country of Origin
// Along with a single, random user review in a CommentCard. There is also a button that
// brings the user to the CommentList page for the movie.

import 'dart:convert';
import 'package:api/components/functions/global.dart';
import 'package:api/components/functions/round_rating.dart';
import 'package:api/components/functions/random_number.dart';
import 'package:api/components/functions/null_check.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../colours.dart';
import '../components/comment/comment_card.dart';
import '../components/comment/comment_list.dart';
import '../components/functions/db.dart';
import '../components/functions/get_image.dart';
import 'package:api/components/fab.dart';
import 'saved_page.dart';

class MoviePage extends StatefulWidget {
// class MoviePage extends StatelessWidget {

  final String api;
  final String reviewsAPI;
  final String movieID;
  final String posterPath;
  const MoviePage({super.key, required this.api, required this.reviewsAPI, required this.movieID, required this.posterPath});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late Future<String> futureMovie;
  late Future<String> reviews;
  late String movieTitle = " ";

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovie(widget.api);
    reviews = fetchReviews(widget.reviewsAPI);
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(movieTitle),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: futureMovie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map jsonMap = json.decode(snapshot.data!);
              // This parses the release date value from the API response so it can be displayed in a nicer way
              DateTime relDate = DateTime.parse(nullCheck(jsonMap['release_date']));
              // This is from the 'intl' package and parses a number to a nicer format
              final value = NumberFormat("#,###", "en_US");
              // print("Movie ID is: ${jsonMap['id']}");
              return ListView(
                children: [
                  Column(
                    // scrollDirection: Axis.vertical,
                    children: [
                      getMovieImage(jsonMap['backdrop_path']),
                      // getMovieImage(jsonMap['poster_path']),
                    ],
                  ),

                  // This is the banner image at the top of the page
                  // Image.network(
                  //     'https://image.tmdb.org/t/p/w500${jsonMap['backdrop_path']}'),
                  // This is the tagline of the movie below the poster
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 0, left: 16, right: 16),
                    child: Column(children: [
                      Text(
                        // jsonMap['tagline'] ?? "loading...",
                        '"${nullCheck(jsonMap['tagline'])}"',
                        style: const TextStyle(color: fontPrimary),
                      ),
                    ]),
                  ),
                  // This is the overview of the movie
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      Text(
                        nullCheck(jsonMap['overview']),
                        style: const TextStyle(color: fontPrimary),
                      ),
                    ]),
                  ),
                  const Divider(
                    color: secondaryColour,
                    indent: 10,
                    endIndent: 10,
                    height: 5,
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: secondaryColour,
                          radius: 35,
                          child: Text(
                            roundRating(nullCheck(jsonMap['vote_average'].toString()), count),
                            style: textPrimaryBold28,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "${nullCheck(value.format(jsonMap['vote_count'])).toString()} votes",
                            style: textPrimaryBold18,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
                    child: Column(
                      children: [
                        // Center(
                        //   child:
                        Container(
                          width: double.infinity,
                          height: 75.0,
                          alignment: Alignment.center,
                          child: ListView.builder(
                            itemCount: jsonMap['genres'].length,
                            padding: const EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext c, int i) {
                              Map genre = jsonMap['genres'][i];
                              return Container(
                                margin: const EdgeInsets.only(left: 0, right: 5.0),
                                child: Wrap(
                                  // crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Chip(
                                      elevation: 20,
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      backgroundColor: secondaryColour,
                                      shadowColor: Colors.black,
                                      label: Text(
                                        genre['name'],
                                        style: const TextStyle(fontSize: 12),
                                      ), //Text
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 8, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            "Released:",
                            style: textSecondary16,
                          ),
                          const Spacer(),
                          Text(
                            "${relDate.day}/${relDate.month}/${relDate.year}",
                            style: textPrimary16,
                          )
                        ]),
                        Row(children: [
                          Text(
                            "Runtime:",
                            style: textSecondary16,
                          ),
                          const Spacer(),
                          Text(
                            "${nullCheck(jsonMap['runtime'])} minutes",
                            style: textPrimary16,
                          )
                        ]),
                        Row(children: [
                          Text(
                            "Budget:",
                            style: textSecondary16,
                          ),
                          const Spacer(),
                          Text(
                            "\$${nullCheck(value.format(jsonMap['budget']))}",
                            style: textPrimary16,
                          )
                        ]),
                        Row(children: [
                          Text(
                            "Revenue:",
                            style: textSecondary16,
                          ),
                          const Spacer(),
                          Text(
                            "\$${nullCheck(value.format(jsonMap['revenue']))}",
                            style: textPrimary16,
                          )
                        ]),
                        Row(children: [
                          Text(
                            "Original Country:",
                            style: textSecondary16,
                          ),
                          const Spacer(),
                          Text(
                            arrayCheckCountryOrigin(jsonMap['production_companies']),
                            style: textPrimary16,
                          )
                        ]),
                        Row(children: [
                          Text(
                            "ID:",
                            style: textSecondary16,
                          ),
                          const Spacer(),
                          Text(
                            jsonMap['id'].toString(),
                            style: textPrimary16,
                          )
                        ]),
                      ],
                    ),
                  ),
                  const Divider(
                    color: secondaryColour,
                    indent: 10,
                    endIndent: 10,
                    height: 5,
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      "User Reviews",
                      style: textPrimaryBold28,
                    ),
                  ),
                  FutureBuilder<String>(
                    future: reviews,
                    builder: (context, reviewSnapshot) {
                      if (reviewSnapshot.hasData) {
                        Map jsonMapReviews = json.decode(reviewSnapshot.data!);
                        if (jsonMapReviews['results'].length > 0) {
                          int ranNum = randomNumber(0, jsonMapReviews['results'].length);
// This parses the release date value from the API response so it can be displayed in a nicer way
                          return Column(
                            children: [
                              CommentCard(
                                authorUsername: jsonMapReviews['results'][ranNum]['author_details']['username'],
                                profilePicture: jsonMapReviews['results'][ranNum]['author_details']['avatar_path'],
                                reviewContent: jsonMapReviews['results'][ranNum]['content'],
                                reviewRating: jsonMapReviews['results'][ranNum]['author_details']['rating'].toString(),
                                reviewDate: jsonMapReviews['results'][ranNum]['created_at'],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CommentList(
                                                api: 'https://api.themoviedb.org/3/movie/${widget.movieID}/reviews?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page={*}',
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
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator(
                            color: secondaryDarker,
                            backgroundColor: secondaryColour,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
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
        movieID: widget.movieID,
        posterPath: widget.posterPath,
        watchList: resultList,
        // key: UniqueKey(),
      ),
      // FloatingActionButton.large(
      //   onPressed: (() => addUser(userRef)),
      //   tooltip: 'Save',
      //   child: const Icon(Icons.favorite),
      // ),
    );
  }

  Future<String> fetchMovie(String api) async {
// Future<Movie> fetchMovie() async {
    // https://api.themoviedb.org/3/movie/{movie_id}?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Movie.fromJson(jsonDecode(response.body));
      setState(() {
        var res = json.decode(response.body);
        movieTitle = res['title'];
      });

      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movie information');
    }
  }

  Future<String> fetchReviews(String api) async {
    // https://api.themoviedb.org/3/movie/{movie_id}/reviews?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      setState(() {
        // ignore: unused_local_variable
        var reviewRes = json.decode(response.body);
      });
      return response.body;
    } else {
      throw Exception('Failed to load reviews');
    }
  }
}
