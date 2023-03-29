// This is the main page of the app. It contains multiple MovieSliders
// that show either trending movies weekly/daily or movies from
// certain genres.

import 'package:api/colours.dart';
import 'package:api/components/movie/movie_slider.dart';
import 'package:flutter/material.dart';
import 'package:api/main.dart';
import 'package:api/components/navigation.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<MovieSlider> sliders = [];

  @override
  initState() {
    super.initState();
    appSetup();
    sliders = [
      const MovieSlider(
        sliderTitle: "Popular today",
        api: 'https://api.themoviedb.org/3/trending/movie/day?&api_key=21cc517d0bad572120d1663613b3a1a7',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Popular this week",
        api: 'https://api.themoviedb.org/3/trending/movie/week?&api_key=21cc517d0bad572120d1663613b3a1a7',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Action",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=28',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Animation",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=16',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Comedy",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=35',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Crime",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=80',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Drama",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=18',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Family",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=10751',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "History",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=36',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Horror",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=27',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Mystery",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=9648',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Sci Fi",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=878',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "Thriller",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=53',
        previousRoute: "Discover",
      ),
      const MovieSlider(
        sliderTitle: "War",
        api: 'https://api.themoviedb.org/3/discover/movie?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&with_genres=10752',
        previousRoute: "Discover",
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Discover"),
          actions: [searchButton(context)],
        ),
        body: getSliderList(sliders),
        drawer: Drawer(
          child: drawerNavigation(context),
        ),
      ),
    );
  }

  Widget getSliderList(list) {
    if (list.length != null) {
      return ListView.builder(
          cacheExtent: 3000.0,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return MovieSlider(
              api: list[index].api,
              sliderTitle: list[index].sliderTitle,
              previousRoute: list[index].previousRoute,
            );
          });
    } else {
      return const Text(
        "ERROR",
        style: TextStyle(color: fontPrimary),
      );
    }
  }
}
