// This component is a page that takes all the comments for a given movie and
// lists them in CommentCards.

import 'dart:convert';
import 'package:api/colours.dart';
import 'package:api/components/comment/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentList extends StatefulWidget {
  int? id;
  CommentList({super.key, required this.id});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late Future<String> futureReviews;

  @override
  void initState() {
    futureReviews = fetchReviews(widget.id);
    super.initState();
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
        title: const Text("Reviews"),
      ),
      body: FutureBuilder<String>(
        future: futureReviews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map reviewDetails = json.decode(snapshot.data!);

            return Container(
                child: ListView.builder(
              itemCount: reviewDetails['results'].length,
              itemBuilder: (BuildContext c, int i) {
                Map resultItem = reviewDetails['results'][i]!;
                return CommentCard(
                  authorUsername: resultItem['author_details']['username'],
                  profilePicture: resultItem['author_details']['avatar_path'],
                  reviewContent: resultItem['content'],
                  reviewRating: resultItem['author_details']['rating'].toString(),
                  fullContent: false,
                );
              },
            ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Center(
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
    );
  }

  Future<String> fetchReviews(int? id) async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/${id!}/reviews?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load reviews');
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
            'An error occurred while retrieving reviews.',
            style: TextStyle(fontSize: size, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                fetchReviews(widget.id);
              });
            },
            child: Text(
              "Retry",
              style: textSecondaryBold20,
            ),
          ),
        ],
      ),
    );
  }
}
