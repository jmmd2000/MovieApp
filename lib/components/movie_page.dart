// ignore: implementation_imports
import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:http/http.dart' as http;

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
              // movieTitle = jsonMap['title'];
              // Map resultItem = jsonMap['results'];
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
              return ListView(
                children: [
                  // Text(futureMovie.toString()),
                  // Text("test"),

                  Image.network(
                      'https://image.tmdb.org/t/p/w500${jsonMap['backdrop_path']}'),
                  Text(jsonMap['title']),
                  // Image.network(
                  //     'https://image.tmdb.org/t/p/w500${snapshot.data!.poster}'),
                  // Text(snapshot.data!.id.toString()),
                  // Text(snapshot.data!.blurb),
                  // Text(snapshot.data!.releaseDate),
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
