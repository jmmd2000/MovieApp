// This takes all of the users ratings and displays them in a grid

import 'dart:async';
import 'package:api/components/functions/check_if_rated.dart';
import 'package:api/components/functions/movie.dart';
import 'package:api/components/navigation.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: watchlistStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text(
              'Something went wrong',
              style: TextStyle(color: fontPrimary),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: const [
                  Text(
                    "Loading",
                    style: TextStyle(color: fontPrimary),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (12 / 17),
            ),
            physics: const BouncingScrollPhysics(),
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  String s = checkIfRated(data['id'].toString(), ratingsList);
                  Movie m = Movie(
                    data['posterPath'],
                    data['adult'],
                    data['overview'],
                    data['releaseDate'],
                    data['genres'].cast<int>(),
                    data['id'],
                    data['originalTitle'],
                    data['backdropPath'],
                    data['voteCount'],
                    data['voteAverage'].toString(),
                    s,
                  );
                  return MovieThumb(movie: m);
                })
                .toList()
                .cast(),
          );
        },
      ),
      drawer: Drawer(
        child: drawerNavigation(context),
      ),
    );
  }
}
