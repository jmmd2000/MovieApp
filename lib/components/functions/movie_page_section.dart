// This is simply a section for dividing up the MoviePage to allow for better structure
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoviePageSection extends StatelessWidget {
  List<Widget> children = [];
  MoviePageSection({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
