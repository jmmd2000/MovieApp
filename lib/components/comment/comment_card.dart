// This component is a card that displays a users comment about a particular movie.
// It shows their rating, username, profile picture, comment content and the date and time
// it was posted.

import 'package:api/colours.dart';
import 'package:api/components/functions/null_check.dart';
import 'package:api/components/functions/round_rating.dart';
import 'package:api/components/functions/remove_markdown.dart';
import 'package:flutter/material.dart';
import '../functions/get_image.dart';

class CommentCard extends StatelessWidget {
  final String authorUsername;
  final String? profilePicture;
  final String reviewContent;
  final String reviewRating;
  final String reviewDate;
  const CommentCard({
    super.key,
    required this.authorUsername,
    required this.profilePicture,
    required this.reviewContent,
    required this.reviewRating,
    required this.reviewDate,
  });

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        // color: secondaryColour,
        decoration: BoxDecoration(
          border: Border.all(color: secondaryColour),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: secondaryColour,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                  child: CircleAvatar(
                    backgroundImage: getImage(profilePicture),
                    backgroundColor: secondaryColour,
                    radius: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    nullCheck(authorUsername),
                    style: textPrimaryBold18,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                    backgroundColor: bodyBackground,
                    radius: 20,
                    child: Text(
                      roundRating(nullCheck(reviewRating), count),
                      style: textSecondaryBold20,
                    ),
                  ),
                )
              ]),
            ),
            Container(
              // height: 200,
              decoration: const BoxDecoration(
                color: softWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Text(
                      nullCheck(removeMarkdown(reviewContent)),
                      style: const TextStyle(height: 1.3),
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: secondaryColour,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(9),
                    bottomRight: Radius.circular(9),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    reviewDateImprover(reviewDate),
                    style: textPrimary,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  String reviewDateImprover(date) {
    DateTime parsed = DateTime.parse(date);
    String improved = "${parsed.day}/${parsed.month}/${parsed.year}";

    if (parsed.hour < 10) {
      improved += " 0${parsed.hour}:";
    } else {
      improved += " ${parsed.hour}:";
    }

    if (parsed.minute < 10) {
      improved += "0${parsed.minute}";
    } else {
      improved += "${parsed.minute}";
    }

    return improved;
  }
}
