// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/movie_thumb.dart';
import '../colours.dart';

class MovieSlider extends StatefulWidget {
  final String api;
  final String sliderTitle;
  const MovieSlider({super.key, required this.api, required this.sliderTitle});

  @override
  // ignore: no_logic_in_create_state
  State<MovieSlider> createState() => _MovieSliderState();
  // State<MovieSlider> createState() => _MovieSliderState(api, sliderTitle);

}

class _MovieSliderState extends State<MovieSlider> {
  late Future<String> futureMovie;
  // late String api;

  // String sliderTitle;
  _MovieSliderState();
  // _MovieSliderState(this.api, this.sliderTitle);

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovie(widget.api);
  }

  @override
  Widget build(BuildContext context) {
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
                        // color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: secondaryColour,
                indent: 10,
                endIndent: 10,
                height: 5,
                thickness: 2,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: 10,
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext c, int i) {
                    Map resultItem = jsonMap['results'][i];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: MovieThumb(
                        posterPath: resultItem['poster_path'],
                        rating: resultItem['vote_average'].toString(),
                        movieId: resultItem['id'].toString(),
                      ),
                    );
                  },
                ),
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
    );
  }

  Future<String> fetchMovie(String api) async {
// Future<Movie> fetchMovie() async {
    // 'https://api.themoviedb.org/3/movie/popular?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1'
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Movie.fromJson(jsonDecode(response.body));
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movie');
    }
  }
}
