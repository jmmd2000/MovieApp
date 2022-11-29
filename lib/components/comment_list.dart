// This component is a page that takes all the comments for a given movie and
// lists them in CommentCards. As the user scrolls to the bottom of the page,
// it loads the next page of comments and displays them.

import 'dart:convert';
import 'package:api/colours.dart';
import 'package:api/components/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CommentList extends StatefulWidget {
  String api;
  CommentList({super.key, required this.api});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late bool isLastPage;
  late int pageNumber;
  late bool error;
  late bool loading;
  late List<CommentCard> reviewList;
  final int nextPageTrigger = 1;
  late int lastPage;
  late String resultCount = "0";
  String apiURL = "";
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    pageNumber = 1;
    print("pageNum1 = $pageNumber");
    reviewList = [];
    isLastPage = false;
    loading = true;
    error = false;
    apiURL = widget.api;
    // results = fetchReviews(widget.api);
    // Setup the listener.
    controller.addListener(() {
      if (controller.position.atEdge) {
        bool isTop = controller.position.pixels == 0;
        if (!isTop) {
          setState(() {
            if (pageNumber < lastPage) {
              print('TRUEEEEE');
              pageNumber++;
              print("pageNum2 = $pageNumber");
              widget.api = apiURL.replaceAll("{*}", pageNumber.toString());
              fetchReviews(widget.api);
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
        title: const Text("Reviews"),
      ),
      body: buildReviewList(),
    );
  }

  Widget buildReviewList() {
    widget.api = apiURL.replaceAll("{*}", pageNumber.toString());
    fetchReviews(widget.api);
    if (reviewList.isEmpty) {
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
              "$resultCount reviews",
              style: textPrimaryBold18,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            itemCount: reviewList.length + (isLastPage ? 0 : 1),
            itemBuilder: (context, index) {
              if (index == reviewList.length) {
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
              final CommentCard cc = reviewList[index];
              return CommentCard(authorUsername: cc.authorUsername, profilePicture: cc.profilePicture, reviewContent: cc.reviewContent, reviewRating: cc.reviewRating, reviewDate: cc.reviewDate);
            },
          ),
        )
      ],
    );
  }

  Future<void> fetchReviews(String api) async {
    // https://api.themoviedb.org/3/movie/{movie_id}/reviews?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=2
    try {
      final response = await http.get(Uri.parse(api));
      Map responseList = json.decode(response.body);
      lastPage = responseList['total_pages'];

      List<CommentCard> commentCardList = [];
      for (int i = 0; i < responseList['results'].length; i++) {
        commentCardList.add(CommentCard(
          authorUsername: responseList['results'][i]['author_details']['username'],
          profilePicture: responseList['results'][i]['author_details']['avatar_path'],
          reviewContent: responseList['results'][i]['content'],
          reviewDate: responseList['results'][i]['created_at'],
          reviewRating: responseList['results'][i]['author_details']['rating'].toString(),
        ));
      }
      if (mounted) {
        if (pageNumber < lastPage) {
          setState(() {
            isLastPage = commentCardList.length < 20;
            loading = false;
            pageNumber++;
            print("pageNum3 = $pageNumber");
            reviewList.addAll(commentCardList);
            resultCount = responseList['total_results'].toString();
          });
        }
      }
    } catch (e) {
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
            'An error occurred while retrieving reviews.',
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
                fetchReviews(widget.api);
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
