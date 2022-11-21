import 'dart:convert';

import 'package:api/components/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../colours.dart';

class CommentList extends StatelessWidget {
  final String api;
  const CommentList({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    late Future<String> futureReviews = fetchReviews(api);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: futureReviews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map jsonMap = json.decode(snapshot.data!);
              // return SizedBox(
              // height: 200,
              // child:
              return ListView.builder(
                  itemCount: jsonMap['results'].length,
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext c, int i) {
                    // Map resultItem = jsonMap['results'][i];
                    return CommentCard(
                      authorUsername: jsonMap['results'][i]['author_details']
                          ['username'],
                      profilePicture: jsonMap['results'][i]['author_details']
                          ['avatar_path'],
                      reviewContent: jsonMap['results'][i]['content'],
                      reviewRating: jsonMap['results'][i]['author_details']
                              ['rating']
                          .toString(),
                      reviewDate: jsonMap['results'][i]['created_at'],
                    );
                  });
              // );
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

  Future<String> fetchReviews(String api) async {
    // https://api.themoviedb.org/3/movie/{movie_id}/reviews?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=2
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load reviews');
    }
  }
}
