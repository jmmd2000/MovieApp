// This is a Netflix-style movie slider that contains a set number of MovieThumb
// widgets. It slides left and right and has an adaptive position tracker along the top divider
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api/main.dart';
import 'package:api/components/functions/check_if_rated.dart';
import 'package:api/components/functions/movie.dart';
import 'package:api/components/movie/movie_thumb.dart';
import 'package:api/colours.dart';

class MovieSlider extends StatefulWidget {
  final String? api;
  final String sliderTitle;
  final String? previousRoute;

  const MovieSlider({
    super.key,
    this.api,
    required this.sliderTitle,
    this.previousRoute,
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  double xPos = 0.0;
  double screenWidth = 0;
  final controller = ScrollController();
  late Future<String>? futureMovie;

  _MovieSliderState();

  @override
  void initState() {
    super.initState();
    if (widget.api != null) {
      futureMovie = fetchMovie(widget.api);
    }
    xPos = 0.0;
    screenWidth = 0;
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.removeListener(onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: buildFromAPI(),
    );
  }

  onScroll() {
    setState(() {
      // Get the minimum and maximum values for controller.offset
      // Get it as a percentage and multiply that by the screenwidth - 10
      // -10 because the divider design has an indent at start and end = 10,
      // we can set the inital value of the offset but we cant set a max value so we do it this way
      xPos = (controller.offset / controller.position.maxScrollExtent) * (screenWidth - 10);
    });
  }

  Future<String> fetchMovie(String? api) async {
    final response = await http.get(Uri.parse(api!));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Widget buildFromAPI() {
    return FutureBuilder<String>(
      future: futureMovie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map jsonMap = json.decode(snapshot.data!);
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15, bottom: 5),
                    child: Text(
                      widget.sliderTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        child: Divider(
                          color: secondaryColour,
                          indent: 10,
                          endIndent: 10,
                          thickness: 2,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: xPos,
                        child: Container(
                          height: 6,
                          width: 10,
                          decoration: BoxDecoration(
                            color: secondaryColour,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: lengthCheck(jsonMap['results'].length),
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  itemBuilder: (BuildContext c, int i) {
                    Map resultItem = jsonMap['results'][i];
                    String s = checkIfRated(resultItem['id'].toString(), ratingsList);
                    Movie m = Movie(resultItem['poster_path'], resultItem['adult'], resultItem['overview'], resultItem['release_date'], resultItem['genre_ids'].cast<int>(), resultItem['id'],
                        resultItem['original_title'], resultItem['backdrop_path'], resultItem['vote_count'], resultItem['vote_average'].toString(), s);
                    return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: MovieThumb(
                          movie: m,
                          previousRoute: widget.previousRoute,
                        ));
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(
              color: secondaryDarker,
              backgroundColor: secondaryColour,
            ),
          ),
        );
      },
    );
  }

  int lengthCheck(length) {
    if (length < 10) {
      return length;
    } else {
      return 10;
    }
  }
}
