// ignore: implementation_imports
import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:http/http.dart' as http;
import 'package:navbar_router/navbar_router.dart';
import '../colours.dart';

class MoviePage extends StatefulWidget {
  final String api;
  const MoviePage({super.key, required this.api});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late Future<String> futureMovie;
  late String movieTitle = " ";
  // late String movieTitle = " ";

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovie(widget.api);
  }

  @override
  Widget build(BuildContext context) {
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
              return ListView(
                children: [
                  // This is the banner image at the top of the page
                  Image.network(
                      'https://image.tmdb.org/t/p/w500${jsonMap['backdrop_path']}'),
                  // This is the overview of the movie below the poster
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      jsonMap['overview'],
                      style: const TextStyle(color: fontPrimary),
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
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 8, left: 16, right: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 100.0,
                          child: ListView.builder(
                            itemCount: jsonMap['genres'].length,
                            padding: const EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext c, int i) {
                              Map genre = jsonMap['genres'][i];
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Chip(
                                  elevation: 20,
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  backgroundColor: secondaryColour,
                                  shadowColor: Colors.black,
                                  label: Text(
                                    genre['name'],
                                    style: const TextStyle(fontSize: 12),
                                  ), //Text
                                ),
                              );
                            },
                          ),
                        )
                      ],
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
        ),
      ),
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
}
