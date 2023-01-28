// ignore_for_file: prefer_const_constructors, avoid_print

// import 'dart:async';
// import 'dart:convert';
// import 'dart:ffi';
// import 'dart:html'

// import 'package:api/colours.dart';
import 'package:api/colours.dart';
import 'package:http/testing.dart';

import '../components/movie/movie_slider.dart';
import 'package:flutter/material.dart';
import 'package:api/main.dart';
// import '../firebaseInit.dart';
import 'search_page.dart';
import '../components/functions/auth.dart';
// import 'package:http/http.dart' as http;
import '../components/navigation.dart';
import '../components/functions/global.dart';

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
  String greeting = "Welcome";
  List<MovieSlider> sliders = [];
  // int counter = 0;

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
  void initState() {
    // print("(discover_page.dart)(initState) resultlist ${resultList.length}");

    sliders.addAll([
      MovieSlider(sliderTitle: "Trending Daily", api: 'https://api.themoviedb.org/3/trending/movie/day?&api_key=21cc517d0bad572120d1663613b3a1a7'),
      MovieSlider(sliderTitle: "Trending Weekly", api: 'https://api.themoviedb.org/3/trending/movie/week?&api_key=21cc517d0bad572120d1663613b3a1a7'),
      MovieSlider(sliderTitle: "Upcoming", api: 'https://api.themoviedb.org/3/movie/upcoming?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1'),
      MovieSlider(sliderTitle: "Trending Daily", api: 'https://api.themoviedb.org/3/trending/movie/day?&api_key=21cc517d0bad572120d1663613b3a1a7'),
      MovieSlider(sliderTitle: "Trending Weekly", api: 'https://api.themoviedb.org/3/trending/movie/week?&api_key=21cc517d0bad572120d1663613b3a1a7'),
      MovieSlider(sliderTitle: "Upcoming", api: 'https://api.themoviedb.org/3/movie/upcoming?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1'),
      MovieSlider(sliderTitle: "Trending Daily", api: 'https://api.themoviedb.org/3/trending/movie/day?&api_key=21cc517d0bad572120d1663613b3a1a7'),
      MovieSlider(sliderTitle: "Trending Daily", api: 'https://api.themoviedb.org/3/trending/movie/day?&api_key=21cc517d0bad572120d1663613b3a1a7'),
      MovieSlider(sliderTitle: "Trending Weekly", api: 'https://api.themoviedb.org/3/trending/movie/week?&api_key=21cc517d0bad572120d1663613b3a1a7'),
      MovieSlider(sliderTitle: "Upcoming", api: 'https://api.themoviedb.org/3/movie/upcoming?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1'),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (auth.currentUser != null) {
    //   setState(() {
    //     greeting = "Welcome ${auth.currentUser!.displayName.toString()}";
    //   });
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(greeting),
        actions: [searchButton(context)],
      ),
      body: getSliderList(sliders),
      drawer: Drawer(
        child: drawerNavigation(context),
      ),
    );
  }
}

Widget getSliderList(list) {
  if (list.length != null) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          // access element from list using index
          // you can create and return a widget of your choice
          return MovieSlider(api: list[index].api, sliderTitle: list[index].sliderTitle);
        });

    // ListView(
    //   scrollDirection: Axis.vertical,
    //   children: [
    //     list.forEach((slider) => {MovieSlider(api: slider.api, sliderTitle: slider.sliderTitle)})
    //   ],
    // );
  } else {
    return Text(
      "ERROR",
      style: const TextStyle(color: fontPrimary),
    );
  }
}
