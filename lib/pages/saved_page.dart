// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';

import 'package:api/components/functions/auth.dart';
import 'package:api/components/functions/db.dart';
import 'package:api/components/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import '../colours.dart';
import 'package:api/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../colours.dart';
import '../components/movie/movie_thumb.dart';
import '../components/functions/global.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  // final Stream<DatabaseEvent> watchlist = (() {
  //   late final StreamController<DatabaseEvent> controller;
  //   controller = StreamController<DatabaseEvent>(
  //     onListen: () async {
  //       // DatabaseEvent event = await watchlistRef.once();
  //       watchlistRef.onValue.listen((DatabaseEvent event) {
  //         final data = event.snapshot.value;
  //         // updateStarCount(data);
  //       });
  //       // await Future<void>.delayed(const Duration(seconds: 1));
  //       // controller.add(1);
  //       // await Future<void>.delayed(const Duration(seconds: 1));
  //       // await controller.close();
  //     },
  //   );
  //   return controller.stream;
  // })();

  late Future<DatabaseEvent> event;
  // List<MovieThumb> resultList = fetchWatchlist();
  // List<MovieThumb> resultList = [];
  // late final Map map;
  // late List keys = [];
  @override
  initState() {
    print("(saved_page)(initState) State initialised");
    // resultList = fetchWatchlist();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> watchlistStream = FirebaseFirestore.instance.collection('watchlist').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        // automaticallyImplyLeading: false,
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

          // return Column(
          //   children: [
          //     Expanded(
          //       child: GridView.builder(
          //         controller: null,
          //         physics: const BouncingScrollPhysics(),
          //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 3,
          //           childAspectRatio: (12 / 17),
          //         ),
          //         itemCount: resultList.length,
          //         itemBuilder: (context, index) {
          //           // print("BWL");
          //           // print("RL" + resultList.toString());
          //           // print("K" + keys.toString());
          //           // Map? map = watchlist as Map?;
          //           // print("M" + map.toString());

          //           // for (String key in keys) {
          //           //   // print("movieid = ${map?[key]["movieID"]}");
          //           //   resultList.add(
          //           //     MovieThumb(
          //           //       movieId: map?[key]["movieID"] as String,
          //           //       posterPath: map?[key]["posterPath"] as String,
          //           //       rating: map?[key]["uid"] as String,
          //           //     ),
          //           //   );
          //           //   print("added");
          //           // }
          //           // final watchlistRef = db.collection("watchlist");
          //           // watchlistRef.onChildAdded.listen((event) {
          //           //   // A new comment has been added, so add it to the displayed list.
          //           // });
          //           // if (index == resultList.length) {
          //           //   // if (error) {
          //           //   //   return Center(child: errorDialog(size: 15));
          //           //   // } else {
          //           //   return const Center(
          //           //       child: Padding(
          //           //     padding: EdgeInsets.all(8),
          //           //     child: CircularProgressIndicator(),
          //           //   ));
          //           //   // }
          //           // }
          //           print("(saved_page.dart)(Scaffold)1 resultList.length = ${resultList.length}");
          //           final MovieThumb mt = resultList[index];
          //           print("(saved_page.dart)(Scaffold) MovieThumb(posterPath: ${mt.posterPath}, rating: ${mt.rating}, movieId: ${mt.movieId})");
          //           return MovieThumb(
          //             movieId: mt.movieId,
          //             posterPath: mt.posterPath,
          //             rating: mt.rating,
          //           );
          //         },
          //       ),
          //     )
          //   ],
          // );

          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (12 / 17),
            ),
            physics: const BouncingScrollPhysics(),
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  print(" saved resultlist.length= ${resultList.length}");

                  return MovieThumb(posterPath: data['posterPath'], rating: data['uid'], movieId: data['movieID']);
                  // return ListTile(
                  //   title: Text(
                  //     data['posterPath'],
                  //     style: const TextStyle(color: fontPrimary),
                  //   ),
                  //   subtitle: Text(
                  //     data['uid'],
                  //     style: const TextStyle(color: fontPrimary),
                  //   ),
                  // );
                })
                .toList()
                .cast(),
          );
        },
      ),
      // Column(
      //   children: [
      //     Expanded(
      //       child: GridView.builder(
      //         controller: null,
      //         physics: const BouncingScrollPhysics(),
      //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 3,
      //           childAspectRatio: (12 / 17),
      //         ),
      //         itemCount: resultList.length,
      //         itemBuilder: (context, index) {
      //           // print("BWL");
      //           // print("RL" + resultList.toString());
      //           // print("K" + keys.toString());
      //           // Map? map = watchlist as Map?;
      //           // print("M" + map.toString());

      //           // for (String key in keys) {
      //           //   // print("movieid = ${map?[key]["movieID"]}");
      //           //   resultList.add(
      //           //     MovieThumb(
      //           //       movieId: map?[key]["movieID"] as String,
      //           //       posterPath: map?[key]["posterPath"] as String,
      //           //       rating: map?[key]["uid"] as String,
      //           //     ),
      //           //   );
      //           //   print("added");
      //           // }

      //           // watchlistRef.onChildAdded.listen((event) {
      //           //   // A new comment has been added, so add it to the displayed list.
      //           // });
      //           // if (index == resultList.length) {
      //           //   // if (error) {
      //           //   //   return Center(child: errorDialog(size: 15));
      //           //   // } else {
      //           //   return const Center(
      //           //       child: Padding(
      //           //     padding: EdgeInsets.all(8),
      //           //     child: CircularProgressIndicator(),
      //           //   ));
      //           //   // }
      //           // }
      //           final MovieThumb mt = resultList[index];
      //           print(mt);
      //           return MovieThumb(
      //             movieId: mt.movieId,
      //             posterPath: mt.posterPath,
      //             rating: mt.rating,
      //           );
      //         },
      //       ),
      //     )
      //   ],
      // ),
      // StreamBuilder<DatabaseEvent>(
      //   stream: watchlist,
      //   builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
      //     List<Widget> children;
      //     if (snapshot.hasError) {
      //       children = <Widget>[
      //         const Icon(
      //           Icons.error_outline,
      //           color: Colors.red,
      //           size: 60,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 16),
      //           child: Text('Error: ${snapshot.error}'),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 8),
      //           child: Text('Stack trace: ${snapshot.stackTrace}'),
      //         ),
      //       ];
      //     } else {
      //       switch (snapshot.connectionState) {
      //         case ConnectionState.none:
      //           children = const <Widget>[
      //             Icon(
      //               Icons.info,
      //               color: Colors.blue,
      //               size: 60,
      //             ),
      //             Padding(
      //               padding: EdgeInsets.only(top: 16),
      //               child: Text('Could not retrieve watchlist data.'),
      //             ),
      //           ];
      //           break;
      //         case ConnectionState.waiting:
      //           children = const <Widget>[
      //             SizedBox(
      //               width: 60,
      //               height: 60,
      //               child: Center(
      //                 child: Padding(
      //                   padding: EdgeInsets.all(40),
      //                   child: CircularProgressIndicator(
      //                     color: secondaryDarker,
      //                     backgroundColor: secondaryColour,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Padding(
      //               padding: EdgeInsets.only(top: 16),
      //               child: Text('Awaiting bids...'),
      //             ),
      //           ];
      //           break;
      //         case ConnectionState.active:
      //           children = <Widget>[
      //             const Icon(
      //               Icons.check_circle_outline,
      //               color: Colors.green,
      //               size: 60,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 16),
      //               child: Text('\$${snapshot.data}'),
      //             ),
      //           ];
      //           break;
      //         case ConnectionState.done:
      //           children = <Widget>[
      //             Column(
      //               children: [
      //                 Expanded(
      //                   child: GridView.builder(
      //                     controller: null,
      //                     physics: const BouncingScrollPhysics(),
      //                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                       crossAxisCount: 3,
      //                       childAspectRatio: (12 / 17),
      //                     ),
      //                     itemCount: resultList.length,
      //                     itemBuilder: (context, index) {
      //                       print("BWL");
      //                       // print("RL" + resultList.toString());
      //                       print("K" + keys.toString());
      //                       Map? map = watchlist as Map?;
      //                       print("M" + map.toString());

      //                       for (String key in keys) {
      //                         // print("movieid = ${map?[key]["movieID"]}");
      //                         resultList.add(
      //                           MovieThumb(
      //                             movieId: map?[key]["movieID"] as String,
      //                             posterPath: map?[key]["posterPath"] as String,
      //                             rating: map?[key]["uid"] as String,
      //                           ),
      //                         );
      //                         print("added");
      //                       }

      //                       // watchlistRef.onChildAdded.listen((event) {
      //                       //   // A new comment has been added, so add it to the displayed list.
      //                       // });
      //                       // if (index == resultList.length) {
      //                       //   // if (error) {
      //                       //   //   return Center(child: errorDialog(size: 15));
      //                       //   // } else {
      //                       //   return const Center(
      //                       //       child: Padding(
      //                       //     padding: EdgeInsets.all(8),
      //                       //     child: CircularProgressIndicator(),
      //                       //   ));
      //                       //   // }
      //                       // }
      //                       final MovieThumb mt = resultList[index];
      //                       print(mt);
      //                       return MovieThumb(
      //                         movieId: mt.movieId,
      //                         posterPath: mt.posterPath,
      //                         rating: mt.rating,
      //                       );
      //                     },
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ];
      //           break;
      //       }
      //     }
      //     // Map map = json.decode(snapshot.data!);
      //     Map? map = snapshot.data?.snapshot.value as Map?;
      //     print("RL" + resultList.toString());
      //     // This parses the release date value from the API response so it can be displayed in a nicer way
      //     // DateTime relDate = DateTime.parse(nullCheck(jsonMap['release_date']));
      //     // This is from the 'intl' package and parses a number to a nicer format
      //     // final value = NumberFormat("#,###", "en_US");
      //     // print("Movie ID is: ${jsonMap['id']}");
      //     // if (snapshot != null) {
      //     //   // for (DataSnapshot child in snapshot.data!.snapshot.children) {
      //     //   //   // keys.add(child.key);
      //     //   //   // print("movieid = ${map?[child.key]["movieID"]}");
      //     //   //   // map2 = event.snapshot.children as Map;
      //     //   //   // print(keys.toString());
      //     //   //   resultList.add(MovieThumb(posterPath: map![child.key]['posterPath'].toString(), rating: map[child.key]['uid'].toString(), movieId: map[child.key]['movieID'].toString()));
      //     //   //   print(resultList);
      //     //   // }
      //     // }

      //     // return Text("map " + map!['-NMivsGYHj6Pqt_l9tYQ']['movieID'].toString());

      //     return Column(
      //       children: [
      //         Expanded(
      //           child: GridView.builder(
      //             controller: null,
      //             physics: const BouncingScrollPhysics(),
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 3,
      //               childAspectRatio: (12 / 17),
      //             ),
      //             itemCount: resultList.length,
      //             itemBuilder: (context, index) {
      //               print("BWL");
      //               // print("RL" + resultList.toString());
      //               print("K" + keys.toString());
      //               print("M" + map.toString());
      //               for (String key in keys) {
      //                 // print("movieid = ${map?[key]["movieID"]}");
      //                 resultList.add(
      //                   MovieThumb(
      //                     movieId: map?[key]["movieID"] as String,
      //                     posterPath: map?[key]["posterPath"] as String,
      //                     rating: map?[key]["uid"] as String,
      //                   ),
      //                 );
      //                 print("added");
      //               }

      //               watchlistRef.onChildAdded.listen((event) {
      //                 // A new comment has been added, so add it to the displayed list.
      //               });
      //               // if (index == resultList.length) {
      //               //   // if (error) {
      //               //   //   return Center(child: errorDialog(size: 15));
      //               //   // } else {
      //               //   return const Center(
      //               //       child: Padding(
      //               //     padding: EdgeInsets.all(8),
      //               //     child: CircularProgressIndicator(),
      //               //   ));
      //               //   // }
      //               // }
      //               final MovieThumb mt = resultList[index];
      //               print(mt);
      //               return MovieThumb(
      //                 movieId: mt.movieId,
      //                 posterPath: mt.posterPath,
      //                 rating: mt.rating,
      //               );
      //             },
      //           ),
      //         )
      //       ],
      //     );
      //     // } else if (snapshot.hasError) {
      //     //   return Text('${snapshot.error}');
      //     // }

      //     // By default, show a loading spinner.
      //     // return const Center(
      //     //   child: Padding(
      //     //     padding: EdgeInsets.all(40),
      //     //     child: CircularProgressIndicator(
      //     //       color: secondaryDarker,
      //     //       backgroundColor: secondaryColour,
      //     //     ),
      //     //   ),
      //     // );
      //   },
      // ),
      // buildWatchlist(),
      // body: Column(
      //   children: [
      //     ElevatedButton(
      //       onPressed: () {
      //         signOut(context: context, user: auth.currentUser);
      //         // setUserInfo(initalRef);
      //         // if (user != null) {
      //         //   setState(() {
      //         //     answer = "Goodbye";
      //         //   });
      //         // } else {
      //         //   setState(() {
      //         //     answer = "error";
      //         //   });
      //         // }
      //       },
      //       child: const Text("Log out"),
      //       // child: const Text("db121"),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         // signOut(context: context, user: auth.currentUser);
      //         addUser(userRef);
      //         // if (user != null) {
      //         //   setState(() {
      //         //     answer = "Goodbye";
      //         //   });
      //         // } else {
      //         //   setState(() {
      //         //     answer = "error";
      //         //   });
      //         // }
      //       },
      //       // child: const Text("Log out"),
      //       child: const Text("add"),
      //     ),

      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          // Fluttertoast.showToast(
          //     msg: "Error adding to watchlist",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     // timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: fontPrimary,
          //     fontSize: 16.0);
          // signOut(context: context, user: auth.currentUser);
          // storeUser();
          // setState(() {
          //   resultList = fetchWatchlist();
          // });
        }),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: drawerNavigation(context),
      ),
    );
  }

  // Widget buildWatchlist() {
  //   // print("BWL");
  //   // print("RL" + resultList.toString());
  //   // print("K" + keys.toString());
  //   // print("M" + map.toString());
  //   // for (String key in keys) {
  //   //   // print("movieid = ${map?[key]["movieID"]}");
  //   //   resultList.add(
  //   //     MovieThumb(
  //   //       movieId: map[key]["movieID"] as String,
  //   //       posterPath: map[key]["posterPath"] as String,
  //   //       rating: map[key]["uid"] as String,
  //   //     ),
  //   //   );
  //   //   print("added");
  //   // }
  //   // // if (map.isEmpty) {
  //   // //   // if (loading) {
  //   // //   //   return const Center(
  //   // //   //     child: Padding(
  //   // //   //       padding: EdgeInsets.all(8),
  //   // //   //       child: CircularProgressIndicator(),
  //   // //   //     ),
  //   // //   //   );
  //   // //   // } else if (error) {
  //   // //   //   return Center(child: errorDialog(size: 20));
  //   // //   // }
  //   // //   print("empty");
  //   // // }
  //   return Column(
  //     children: [
  //       Expanded(
  //         child: GridView.builder(
  //           controller: null,
  //           physics: const BouncingScrollPhysics(),
  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 3,
  //             childAspectRatio: (12 / 17),
  //           ),
  //           itemCount: resultList.length,
  //           itemBuilder: (context, index) {
  //             if (index == resultList.length) {
  //               // if (error) {
  //               //   return Center(child: errorDialog(size: 15));
  //               // } else {
  //               return const Center(
  //                   child: Padding(
  //                 padding: EdgeInsets.all(8),
  //                 child: CircularProgressIndicator(),
  //               ));
  //               // }
  //             }
  //             final MovieThumb mt = resultList[index];
  //             print(mt);
  //             return MovieThumb(
  //               movieId: mt.movieId,
  //               posterPath: mt.posterPath,
  //               rating: mt.rating,
  //             );
  //           },
  //         ),
  //       )
  //     ],
  //   );
  //   // return Column();
  // }

}
