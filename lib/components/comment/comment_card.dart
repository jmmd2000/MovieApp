// This component is a card that displays a users comment about a particular movie.
// It shows their rating, username, profile picture, comment content and the date and time
// it was posted.

import 'package:api/colours.dart';
import 'package:api/components/functions/null_check.dart';
import 'package:api/components/functions/round_rating.dart';
import 'package:api/components/functions/remove_markdown.dart';
import 'package:api/pages/comment_page.dart';
import 'package:flutter/material.dart';
import 'package:api/components/functions/get_image.dart';

class CommentCard extends StatelessWidget {
  final String authorUsername;
  final String? profilePicture;
  final String reviewContent;
  final String reviewRating;
  final bool fullContent;
  const CommentCard({
    super.key,
    required this.authorUsername,
    required this.profilePicture,
    required this.reviewContent,
    required this.reviewRating,
    required this.fullContent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommentPage(
              authorUsername: authorUsername,
              profilePicture: profilePicture,
              reviewContent: reviewContent,
              reviewRating: reviewRating,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: getImage(profilePicture),
                    backgroundColor: secondaryColour,
                    radius: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: secondaryColour,
                    radius: 25,
                    child: Text(
                      checkRating(reviewRating),
                      style: textPrimaryBold22,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        nullCheck(authorUsername) ? authorUsername : "Error retrieving username.",
                        style: textPrimaryBold18,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: secondaryColour),
                      bottom: BorderSide(color: secondaryColour),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: fullContent ? fullSize() : limitedSize(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  checkRating(rating) {
    if (rating.toString() == "null") {
      return "N/A";
    } else {
      return roundRating(double.parse(rating));
    }
  }

  Widget limitedSize() {
    return SizedBox(
      height: 200,
      width: 300,
      child: Text(
        nullCheck(removeMarkdown(reviewContent)) ? removeMarkdown(reviewContent) : "Error retrieving review content.",
        overflow: TextOverflow.fade,
        style: textPrimary12,
      ),
    );
  }

  Widget fullSize() {
    return SizedBox(
      width: 300,
      child: Text(
        nullCheck(removeMarkdown(reviewContent)) ? removeMarkdown(reviewContent) : "Error retrieving review content.",
        overflow: TextOverflow.fade,
        style: textPrimary12,
      ),
    );
  }
}
