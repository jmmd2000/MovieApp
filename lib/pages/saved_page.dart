// This takes all of the movies in the users watchlist and
// displays them in a grid

import 'dart:async';
import 'package:api/components/functions/auth.dart';
import 'package:api/components/functions/check_if_rated.dart';
import 'package:api/components/functions/get_image.dart';
import 'package:api/components/functions/movie.dart';
import 'package:api/components/navigation.dart';
import 'package:api/components/sort_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:api/main.dart';
import 'package:api/colours.dart';
import 'package:api/components/movie/movie_thumb.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late Future<DatabaseEvent> event;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> watchlistStream = FirebaseFirestore.instance.collection('watchlist').where("uid", isEqualTo: auth.currentUser!.uid).snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        actions: [searchButton(context)],
      ),
      body: Column(
        children: [
          checkWatchlist(),
          buildWatchlist(),
        ],
      ),
      // GridView.builder(
      //   cacheExtent: 3000.0,
      //   physics: const BouncingScrollPhysics(),
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 3,
      //     childAspectRatio: (12 / 17),
      //   ),
      //   itemCount: ratingsList.length,
      //   itemBuilder: (context, index) {
      //     if (index == ratingsList.length) {
      //       return const Center(
      //           child: Padding(
      //         padding: EdgeInsets.all(8),
      //         child: CircularProgressIndicator(),
      //       ));
      //     }
      //     final MovieThumb mt = ratingsList[index];
      //     return mt;
      //   },
      // ),

      // StreamBuilder<QuerySnapshot>(
      //   stream: watchlistStream,
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.hasError) {
      //       return const Text(
      //         'Something went wrong',
      //         style: TextStyle(color: fontPrimary),
      //       );
      //     }

      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: Column(
      //           children: const [
      //             Text(
      //               "Loading",
      //               style: TextStyle(color: fontPrimary),
      //             ),
      //             Center(
      //               child: Padding(
      //                 padding: EdgeInsets.all(8),
      //                 child: CircularProgressIndicator(),
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     }

      //     return GridView(
      //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 3,
      //         childAspectRatio: (12 / 17),
      //       ),
      //       physics: const BouncingScrollPhysics(),
      //       children: snapshot.data!.docs
      //           .map((DocumentSnapshot document) {
      //             Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //             String s = checkIfRated(data['id'].toString(), ratingsList);
      //             Movie m = Movie(
      //               data['posterPath'],
      //               data['adult'],
      //               data['overview'],
      //               data['releaseDate'],
      //               data['genres'].cast<int>(),
      //               data['id'],
      //               data['originalTitle'],
      //               data['backdropPath'],
      //               data['voteCount'],
      //               data['voteAverage'].toString(),
      //               s,
      //             );
      //             return MovieThumb(movie: m);
      //           })
      //           .toList()
      //           .cast(),
      //     );
      //   },
      // ),
      drawer: Drawer(
        child: drawerNavigation(context),
      ),
    );
  }

  void refreshSort() {
    setState(() {});
  }

  Widget buildWatchlist() {
    if (watchList.isEmpty) {
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
              "Nothing saved yet!",
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
          itemCount: watchList.length,
          itemBuilder: (context, index) {
            if (index == watchList.length) {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ));
            }
            final MovieThumb mt = watchList[index];
            return mt;
          },
        ),
      );
    }
  }

  Widget checkWatchlist() {
    if (watchList.length < 2) {
      return const SizedBox.shrink();
    } else {
      return SortMenu(
        menuOpen: true,
        textFade: true,
        list: watchList,
        updateParent: refreshSort,
        userRating: false,
      );
    }
  }
}
