// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/movie_thumb.dart';

class MovieSlider extends StatefulWidget {
  final String api;
  final String sliderTitle;
  const MovieSlider({super.key, required this.api, required this.sliderTitle});

  @override
  // ignore: no_logic_in_create_state
  State<MovieSlider> createState() => _MovieSliderState(api, sliderTitle);
}

class _MovieSliderState extends State<MovieSlider> {
  late Future<String> futureMovie;
  late String api;

  String sliderTitle;
  _MovieSliderState(this.api, this.sliderTitle);

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovie(api);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: futureMovie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map jsonMap = json.decode(snapshot.data!);
          // return Text(snapshot.data!.title);
          // return ListView(
          //   children: [
          //     Text(snapshot.data!.title),
          //     Image.network(
          //         'https://image.tmdb.org/t/p/w500${snapshot.data!.backdrop}'),
          //     Image.network(
          //         'https://image.tmdb.org/t/p/w500${snapshot.data!.poster}'),
          //     Text(snapshot.data!.id.toString()),
          //     Text(snapshot.data!.blurb),
          //     Text(snapshot.data!.releaseDate),
          //   ],
          // );
          return Column(
            children: [
              // Wrap(
              //   direction: Axis.horizontal,
              //   crossAxisAlignment: WrapCrossAlignment.end,
              //   spacing: 5,
              //   runSpacing: 5,
              //   children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Text(
                      sliderTitle,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),

              Divider(
                color: Colors.green.shade500,
                indent: 10,
                endIndent: 10,
                height: 5,
                thickness: 2,
              ),

              // ],
              //
              // ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  // gridDelegate:
                  //     const SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2),
                  itemCount: 15,
                  // shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext c, int i) {
                    Map resultItem = jsonMap['results'][i];
                    return MovieThumb(
                      posterPath: resultItem['poster_path'],
                      rating: resultItem['vote_average'].toString(),
                      movieId: resultItem['id'].toString(),
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
            child: CircularProgressIndicator(),
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
