// ignore_for_file: prefer_const_constructors

// import 'dart:async';
// import 'dart:convert';
// import 'dart:ffi';
// import 'dart:html'

import '../components/movie_slider.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<String> fetchMovie() async {
// // Future<Movie> fetchMovie() async {
//   final response = await http.get(Uri.parse(
//       'https://api.themoviedb.org/3/movie/popular?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     // return Movie.fromJson(jsonDecode(response.body));
//     return response.body;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load movie');
//   }
// }

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int counter = 0;

  // void _incrementCounter() {
  // setState(() {
  // This call to setState tells the Flutter framework that something has
  // changed in this State, which causes it to rerun the build method below
  // so that the display can reflect the updated values. If we changed
  // _counter without calling setState(), then the build method would not be
  // called again, and so nothing would appear to happen.
  // counter++;
  // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Discover Page'),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: const [
            MovieSlider(
              sliderTitle: "Trending",
              api:
                  'https://api.themoviedb.org/3/movie/popular?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1',
            ),
            MovieSlider(
                sliderTitle: "Upcoming",
                api:
                    'https://api.themoviedb.org/3/movie/upcoming?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1'),
            MovieSlider(
                sliderTitle: "Upcoming 2",
                api:
                    'https://api.themoviedb.org/3/movie/upcoming?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=2'),
            MovieSlider(
                sliderTitle: "Upcoming 3",
                api:
                    'https://api.themoviedb.org/3/movie/upcoming?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=3'),
          ],
        ));
  }
}