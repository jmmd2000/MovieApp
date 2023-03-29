// This component is a page that lets the user search the api database for any movie.
// It contains a searchbar whos value is interpolated into the search url to return a GridView
// of MovieThumbs.

import 'dart:async';
import 'dart:convert';
import 'package:api/colours.dart';
import 'package:api/components/functions/check_if_rated.dart';
import 'package:api/components/functions/get_image.dart';
import 'package:api/components/functions/movie.dart';
import 'package:api/components/functions/shared_preferences.dart';
import 'package:api/components/movie/movie_thumb.dart';
import 'package:api/components/searchHistory.dart';
import 'package:api/components/sort_menu.dart';
import 'package:api/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<MovieThumb> resultList;
  late bool error;
  late bool loading;
  final controller = ScrollController();
  bool menuDropdownOpen = false;
  bool menuTextFade = false;
  bool searchActive = false;
  var textController = TextEditingController();

  String apiURL = 'https://api.themoviedb.org/3/search/movie?language=en-US&query={...}&page={*}&include_adult=false&api_key=21cc517d0bad572120d1663613b3a1a7';

  @override
  void initState() {
    super.initState();
    error = false;
    loading = false;
    resultList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            searchActive
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        menuDropdownOpen = !menuDropdownOpen;
                        Timer(const Duration(seconds: 1), () => menuTextFade = !menuTextFade);
                      });
                    },
                    icon: const Icon(Icons.sort),
                  )
                : const SizedBox.shrink(),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: secondaryColour,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: "Search movies...",
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColour),
                    ),
                  ),
                  onSubmitted: (value) async {
                    search(value, false);
                  },
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            SortMenu(
              menuOpen: menuDropdownOpen,
              textFade: menuTextFade,
              list: resultList,
              updateParent: refreshSort,
              userRating: false,
            ),
            searchActive ? buildResults() : const SizedBox.shrink(),
            searchActive
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: randomPlaceholderImage(),
                        ),
                        const Text(
                          "Search for a movie!",
                          style: TextStyle(color: fontPrimary, fontSize: 22),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: secondaryColour,
                          ),
                        ),
                        SearchHistory(
                          history: searchHistory,
                          search: search,
                        ),
                      ],
                    )),
                  ),
          ],
        ));
  }

  Widget buildResults() {
    if (resultList.isEmpty) {
      if (loading) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: CircularProgressIndicator(
              color: secondaryDarker,
              backgroundColor: secondaryColour,
            ),
          ),
        );
      } else if (error) {
        return Center(child: errorDialog(size: 20));
      }
    }
    return Expanded(
      child: GridView.builder(
        controller: controller,
        cacheExtent: 3000.0,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (12 / 17),
        ),
        itemCount: resultList.length,
        itemBuilder: (context, index) {
          if (index == resultList.length) {
            if (error) {
              return Center(child: errorDialog(size: 15));
            } else {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ));
            }
          }
          final MovieThumb mt = resultList[index];
          return mt;
        },
      ),
    );
  }

  Future<void> fetchResults(String query) async {
    saveToSearchHistory(query, refreshSort);
    print(searchHistory);
    List<MovieThumb> movieThumbList = [];

    try {
      for (int x = 1; x < 11; x++) {
        final response = await http.get(
          Uri.parse("https://api.themoviedb.org/3/search/movie?language=en-US&query=$query&page=$x&include_adult=false&api_key=21cc517d0bad572120d1663613b3a1a7"),
        );
        Map responseList = json.decode(response.body);
        for (int i = 0; i < responseList['results'].length; i++) {
          String rating = checkIfRated(responseList['results'][i].toString(), ratingsList);
          Movie m = Movie(
              responseList['results'][i]['poster_path'],
              responseList['results'][i]['adult'],
              responseList['results'][i]['overview'],
              responseList['results'][i]['release_date'],
              responseList['results'][i]['genre_ids'].cast<int>(),
              responseList['results'][i]['id'],
              responseList['results'][i]['title'],
              responseList['results'][i]['backdrop_path'],
              responseList['results'][i]['vote_count'],
              responseList['results'][i]['vote_average'].toString(),
              rating);
          if (responseList['results'][i]['poster_path'].toString() != "null") {
            if (responseList['results'][i]['vote_count'] > 10) {
              movieThumbList.add(
                MovieThumb(movie: m),
              );
            }
          }
        }
      }

      setState(() {
        resultList = movieThumbList;
      });
    } catch (e) {
      error = true;
      errorDialog(size: 100);
    }
  }

  Widget errorDialog({required double size}) {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred while retrieving results.',
            style: TextStyle(fontSize: size, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  fetchResults(apiURL);
                });
              },
              child: Text(
                "Retry",
                style: textSecondaryBold20,
              )),
        ],
      ),
    );
  }

  void refreshSort() {
    setState(() {});
  }

  void search(query, fromCallback) {
    if (fromCallback) {
      setState(() {
        textController.text = query;
        searchActive = true;
        loading = true;
        fetchResults(query);
      });
    } else {
      setState(() {
        searchActive = true;
        loading = true;
        fetchResults(query);
      });
    }
  }
}
