import 'dart:convert';

import 'package:api/colours.dart';
import 'package:api/components/movie_thumb.dart';
import 'package:flutter/material.dart';
import 'package:api/components/functions/get_image.dart';

// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:navbar_router/navbar_router.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  String api;
  SearchPage({super.key, required this.api});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String input = "test";
  int result_count = 0;
  List resultList = [];

  @override
  void initState() {
    super.initState();
    // results = fetchResults(widget.api);
  }

  // @override
  // void dispose() {
  //   // ignore: avoid_print
  //   print('Dispose used');
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                cursorColor: secondaryColour,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  // isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  /* -- Text and Icon -- */
                  hintText: "Search movies...",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: secondaryColour,
                  ), // TextStyle
                  /* -- Border Styling -- */
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: secondaryColour,
                    ), // BorderSide
                  ), // OutlineInputBorder
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: secondaryColour,
                    ), // BorderSide
                  ), // OutlineInputBorder
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: secondaryColour,
                    ), // BorderSide
                  ),
                  // OutlineInputBorder
                ),
                onChanged: (value) async {
                  setState(() {
                    input = value;
                    widget.api = widget.api.replaceAll("{...}", input);
                    // results = fetchResults(widget.api);
                    fetchResults(widget.api);
                  });
                }, // InputDecoration
              ),
              // TextField
            ), // Expanded
          ],
        ), // Row,
      ),
      body: checkResult(resultList),
      // ListView(
      //   children: [
      //     Text(
      //       "$resultList",
      //       style: textPrimary,
      //     ),
      //   ],
      // )
      // Column(children: [

//
    );
  }

  Future<String> fetchResults(String api) async {
    // https://api.themoviedb.org/3/search/movie?language=en-US&query=&page=1&include_adult=false&api_key=21cc517d0bad572120d1663613b3a1a7
    final response = await http.get(Uri.parse(api));
    List tempResultList = [];
    if (response.statusCode == 200) {
      for (int i = 0; i < json.decode(response.body)['results'].length; i++) {
        tempResultList.add(json.decode(response.body)['results'][i]);
      }
      setState(() {
        // ignore: unused_local_variable
        var resultsResponse = json.decode(response.body);
        resultList = tempResultList;
      });
      return response.body;
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Widget checkResult(list) {
    if (list.length > 0) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          // crossAxisSpacing: 0,
          // mainAxisSpacing: 0,
          childAspectRatio: (12 / 17),
          // childAspectRatio: (MediaQuery.of(context).size.width /
          //     (MediaQuery.of(context).size.height / 1.47)),
        ),
        // itemCount: jsonMapSearch['results'].length,
        // itemCount: 9,
        itemCount: resultList.length,
        // shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext c, int i) {
          Map resultItem = resultList[i];
          // return Container(
          //   decoration: BoxDecoration(
          //     color: Colors.red,
          //   ),
          //   child: Text(
          //     input,
          //     style: textPrimary,
          //   ),
          // );
          return MovieThumb(
            movieId: resultItem['id'].toString(),
            posterPath: (resultItem['poster_path']).toString(),
            rating: resultItem['vote_average'].toString(),
          );
        },
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 3,
        // ),
      );
    } else {
      return const Text("No results found");
    }
  }
}
