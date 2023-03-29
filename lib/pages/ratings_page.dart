// This takes all of the users ratings and displays them in a grid

import 'dart:async';
import 'package:api/components/functions/check_if_rated.dart';
import 'package:api/components/functions/get_image.dart';
import 'package:api/components/functions/movie.dart';
import 'package:api/components/navigation.dart';
import 'package:api/components/sort_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:api/main.dart';

import '../colours.dart';
import '../components/movie/movie_thumb.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  late Future<DatabaseEvent> event;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> watchlistStream = FirebaseFirestore.instance.collection('ratings').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ratings'),
        actions: [searchButton(context)],
      ),
      body: Column(
        children: [
          checkRatings(),
          buildRatings(),
        ],
      ),
      drawer: Drawer(
        child: drawerNavigation(context),
      ),
    );
  }

  void refreshSort() {
    setState(() {});
  }

  Widget buildRatings() {
    if (ratingsList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: randomPlaceholderImage(),
            ),
            const Text(
              "Nothing rated yet!",
              style: TextStyle(color: fontPrimary, fontSize: 22),
            ),
          ],
        )),
      );
    } else {
      return Expanded(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: (12 / 17),
          ),
          itemCount: ratingsList.length,
          itemBuilder: (context, index) {
            if (index == ratingsList.length) {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ));
            }
            final MovieThumb mt = ratingsList[index];
            return mt;
          },
        ),
      );
    }
  }

  Widget checkRatings() {
    if (ratingsList.length < 2) {
      return const SizedBox.shrink();
    } else {
      return SortMenu(
        menuOpen: true,
        textFade: true,
        list: ratingsList,
        updateParent: refreshSort,
        userRating: true,
      );
    }
  }
}
