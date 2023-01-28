// This component is a page that lets the user search the database for any movie.
// It contains a searchbar whos value is interpolated into the search url to return a GridView
// of MovieThumbs. As the user scrolls to the bottom of the page it loads the next page of results.

import 'dart:convert';
import 'package:api/colours.dart';
import 'package:api/components/movie/movie_thumb.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  String api;
  SearchPage({super.key, required this.api});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late bool isLastPage;
  late int pageNumber;
  late bool error;
  late bool loading;
  late List<MovieThumb> resultList;
  final int nextPageTrigger = 6;
  late int lastPage;
  late String resultCount = "0";
  String apiURL = "";
  String input = "";
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    pageNumber = 1;
    resultList = [];
    isLastPage = false;
    loading = true;
    error = false;
    apiURL = widget.api;
    controller.addListener(() {
      if (controller.position.atEdge) {
        bool isTop = controller.position.pixels == 0;
        if (!isTop) {
          setState(() {
            if (pageNumber < lastPage) {
              pageNumber++;
              widget.api = apiURL.replaceAll("{*}", pageNumber.toString());
              widget.api = widget.api.replaceAll("{...}", input.toString());
              fetchResults(widget.api);
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                cursorColor: secondaryColour,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  // Text and Icon
                  hintText: "Search movies...",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: secondaryColour,
                  ),
                  // Border Styling
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: secondaryColour,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: secondaryColour,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: secondaryColour,
                    ),
                  ),
                ),
                onSubmitted: (value) async {
                  if (value != input) {
                    setState(() {
                      pageNumber = 1;
                      resultList = [];
                      isLastPage = false;
                      loading = true;
                      error = false;
                      input = value;
                      widget.api = widget.api.replaceAll("{...}", input);
                      widget.api = widget.api.replaceAll("{*}", pageNumber.toString());
                      fetchResults(widget.api);
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: buildResults(),
    );
  }

  Widget? buildResults() {
    if (resultList.isEmpty) {
      if (loading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          ),
        );
      } else if (error) {
        return Center(child: errorDialog(size: 20));
      }
    }
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
            child: Text(
              "$resultCount results",
              style: textPrimaryBold18,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (12 / 17),
            ),
            itemCount: resultList.length + (isLastPage ? 0 : 1),
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
              return MovieThumb(
                movieId: mt.movieId,
                posterPath: mt.posterPath,
                rating: mt.rating,
              );
            },
          ),
        )
      ],
    );
  }

  Future<void> fetchResults(String api) async {
    // https://api.themoviedb.org/3/search/movie?language=en-US&query=&page=1&include_adult=false&api_key=21cc517d0bad572120d1663613b3a1a7
    try {
      final response = await http.get(Uri.parse(api));
      Map responseList = json.decode(response.body);
      lastPage = responseList['total_pages'];

      List<MovieThumb> movieThumbList = [];
      for (int i = 0; i < responseList['results'].length; i++) {
        movieThumbList.add(MovieThumb(
            posterPath: responseList['results'][i]['poster_path'].toString(), rating: responseList['results'][i]['vote_average'].toString(), movieId: responseList['results'][i]['id'].toString()));
      }
      // print("Line 263 api === $api");
      setState(() {
        isLastPage = movieThumbList.length < 20;
        loading = false;
        pageNumber++;
        resultList.addAll(movieThumbList);
        resultCount = responseList['total_results'].toString();
      });
    } catch (e) {
      // print("e!!!!!!!! ======= $e");
      loading = false;
      error = true;
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
                  loading = true;
                  error = false;
                  fetchResults(widget.api);
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
}
