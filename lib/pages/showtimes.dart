// This page displays sample data of showtimes for movies that are currently in cinemas

import 'dart:async';
import 'dart:convert';
import 'package:api/components/functions/check_if_rated.dart';
import 'package:api/components/functions/movie.dart';
import 'package:api/components/functions/random_number.dart';
import 'package:api/components/navigation.dart';
import 'package:flutter/material.dart';
import 'package:api/main.dart';
import 'package:api/colours.dart';
import 'package:api/components/movie/movie_thumb.dart';
import 'package:http/http.dart' as http;

class ShowtimePage extends StatefulWidget {
  const ShowtimePage({super.key});

  @override
  State<ShowtimePage> createState() => _ShowtimePageState();
}

class _ShowtimePageState extends State<ShowtimePage> {
  late Future<String> showtimes;
  @override
  initState() {
    super.initState();
    showtimes = fetchNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Showtimes'),
          actions: [searchButton(context)],
        ),
        body: FutureBuilder(
          future: showtimes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map showtimeDetails = json.decode(snapshot.data!);
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Nearby Cinemas",
                        style: textPrimaryBold20,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: showtimeDetails.length,
                        itemBuilder: (BuildContext c, int i) {
                          Map resultItem = showtimeDetails['results'][i]!;
                          String s = checkIfRated(resultItem['id'].toString(), ratingsList);
                          Movie m = Movie(
                            resultItem['poster_path'],
                            resultItem['adult'],
                            resultItem['overview'],
                            resultItem['release_date'],
                            resultItem['genre_ids'].cast<int>(),
                            resultItem['id'],
                            resultItem['title'],
                            resultItem['backdrop_path'],
                            resultItem['vote_count'],
                            resultItem['vote_average'].toString(),
                            s,
                          );
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              height: 200,
                              width: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      children: [
                                        MovieThumb(movie: m),
                                      ],
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          children: generateShowtimes(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
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
        ));
  }

  Future<String> fetchNowPlaying() async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/now_playing?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&region=IE"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load showtimes');
    }
  }

  List<Widget> generateShowtimes() {
    int numberOfShowings = randomNumber(3, 6);
    int runtime = 110;
    List startTimeHours = [1, 2, 3, 4, 5];
    List startTimeMins = [10, 20, 30, 40, 50];
    List offsets = [10, 15, 20];
    int startHour = startTimeHours[randomNumber(0, 4)];
    int startMin = startTimeMins[randomNumber(0, 4)];
    int lastHour = 0;
    int lastMin = 0;

    List<Widget> showtimeChips = [];
    for (int i = 0; i < numberOfShowings; i++) {
      int offset = 15;

      if (i == 0) {
        showtimeChips.add(
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Chip(
              backgroundColor: secondaryColour,
              label: Text(
                "$startHour:$startMin",
                style: textPrimary,
              ),
            ),
          ),
        );
        lastHour = startHour;
        lastMin = startMin;
      } else {
        int totalMins = lastMin + runtime + offset;
        int mod = totalMins % 60;
        int temp = totalMins - mod;
        int temp2 = (temp / 60).round();
        int nextHour = (lastHour + ((totalMins - mod) / 60)).round();
        int nextMin = mod;
        showtimeChips.add(
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Chip(
              backgroundColor: secondaryColour,
              label: Text(
                "$nextHour:$nextMin",
                style: textPrimary,
              ),
            ),
          ),
        );
        lastHour = nextHour.round();
        lastMin = nextMin;
      }
    }

    return showtimeChips;
  }
}
