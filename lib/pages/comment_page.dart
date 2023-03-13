// This is the page that displays a single comment when the user
// taps on it. Mainly for comments that are too long as I have
// limited the length in normal comment cards to only show a certain
// amount.

import 'package:api/components/comment/comment_card.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  final String authorUsername;
  final String? profilePicture;
  final String reviewContent;
  final String reviewRating;
  const CommentPage({
    super.key,
    required this.authorUsername,
    required this.profilePicture,
    required this.reviewContent,
    required this.reviewRating,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment'),
      ),
      body: SingleChildScrollView(
        child: CommentCard(
          authorUsername: widget.authorUsername,
          profilePicture: widget.profilePicture,
          reviewContent: widget.reviewContent,
          reviewRating: widget.reviewRating,
          fullContent: true,
        ),
      ),
    );
  }
}
