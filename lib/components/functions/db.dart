// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:api/components/movie/movie_thumb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth.dart';
import 'global.dart';

// FirebaseDatabase database = FirebaseDatabase.instance;
// // DatabaseReference initalRef = FirebaseDatabase.instance.ref("users");
// // DatabaseReference userRef = FirebaseDatabase.instance.ref("users/123");
// String currentUserID = auth.currentUser!.uid;
// DatabaseReference userRef = FirebaseDatabase.instance.ref("users");

// DatabaseReference watchlistRef = FirebaseDatabase.instance.ref("watchlist/${auth.currentUser!.uid}");

// List<String?> keyList = [];

FirebaseFirestore db = FirebaseFirestore.instance;

void storeUser() {
  print("(db.dart)(storeUser) Called");
  var user = <String, dynamic>{
    "name": auth.currentUser!.displayName,
    "image": auth.currentUser!.photoURL,
    "uid": auth.currentUser!.uid,
  };

  try {
    db.collection("users").add(user).then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
  } catch (error) {
    print("(db.dart)(storeUser) $error");
  } finally {
    print('(db.dart)(storeUser) Done writing to database');
  }
}

bool deleteFromWatchlist(movieID) {
  print("(db.dart)(deleteFromWatchlist) Called");

  try {
    var entry = db.collection('watchlist').where('movieID', isEqualTo: movieID);
    entry.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  } catch (error) {
    print("(db.dart)(deleteFromWatchlist) $error");
    return false;
  } finally {
    print('(db.dart)(deleteFromWatchlist) Done deleting from database');
    return true;
  }
}

bool addtoWatchlist(posterPath, movieID) {
  print("(db.dart)(addtoWatchlist) Called");
  var movie = <String, dynamic>{
    "uid": auth.currentUser!.uid,
    "posterPath": posterPath,
    "movieID": movieID,
  };

  try {
    db.collection("watchlist").add(movie).then((DocumentReference doc) => print('(db.dart)(addtoWatchlist) DocumentSnapshot added with ID: ${doc.id}'));
  } catch (error) {
    print("(db.dart)(addtoWatchlist) $error");
    return false;
  } finally {
    print('(db.dart)(addtoWatchlist) Done writing to database');
    return true;
  }

  // await db.collection("watchlist").get().then((event) {
  //   for (var doc in event.docs) {
  //     print("${doc.id} => ${doc.data()}");
  //   }
  // });
}

List<MovieThumb> fetchWatchlist() {
  print("(db.dart)(fetchWatchlist) FetchedWL");
  QuerySnapshot snapshot;
  List<MovieThumb> watchlist = [];
  print("(db.dart)(fetchWatchlist)1 watchlist.length = ${watchlist.length}");
  db.collection("watchlist").where("uid", isEqualTo: auth.currentUser!.uid).get().then(
    (snapshot) {
      if (snapshot.size < 1) {
        print("(db.dart)(fetchWatchlist) No Matching Documents Retrieved");
      } else {
        snapshot.docs.forEach((doc) {
          watchlist.add(MovieThumb(posterPath: doc['posterPath'], rating: "0", movieId: doc['movieID']));
          print("(db.dart)(fetchWatchlist)2 watchlist.length = ${watchlist.length}");
          print("(db.dart)(fetchWatchlist) snapshot.length = ${snapshot.docs.length}");
          print("(db.dart)(fetchWatchlist)1 MovieThumb: posterPath: ${doc['posterPath']}, uid: ${doc['uid']}, movieID: ${doc['movieID']}");
          watchlist.forEach((element) {
            print("(db.dart)(fetchWatchlist)2 MovieThumb: posterPath: ${element.posterPath}, uid: ${element.rating}, movieID: ${element.movieId}");
          });
        });
        return watchlist;
      }
    },
    onError: (e) => print("(db.dart)(fetchWatchlist) Error completing: $e"),
  );
  print("(db.dart)(fetchWatchlist) -----WL-----");
  print("(db.dart)(fetchWatchlist)3 watchlist.length = ${watchlist.length}");
  watchlist.forEach((element) {
    print("(db.dart)(fetchWatchlist)3 MovieThumb: posterPath: ${element.posterPath}, uid: ${element.rating}, movieID: ${element.movieId}");
  });
  return watchlist;
}

// Future<void> setUserInfo(ref) async {
//   // print(auth);

//   print('Start writing to database');
//   try {
//     await ref.set({
//       "name": auth.currentUser!.displayName,
//       "image": auth.currentUser!.photoURL,
//       "uid": auth.currentUser!.uid,
//     });
//     // await ref.child('title').set('Hello World');
//   } catch (error) {
//     print(error);
//   } finally {
//     print('Done writing to database');
//     DatabaseEvent event = await ref.once();
//     print(event.snapshot.value);
//   }
// }

// addUser(ref) {
//   DatabaseReference newUser = userRef.push();
//   print('Start writing to database');
//   try {
//     // await
//     newUser.set({
//       "name": auth.currentUser!.displayName,
//       "image": auth.currentUser!.photoURL,
//       "uid": auth.currentUser!.uid,
//     });
//     // await ref.child('title').set('Hello World');
//   } catch (error) {
//     print(error);
//   } finally {
//     print('Done writing to database');
//     // DatabaseEvent event = await ref.once();
//     // print(event.snapshot.value);
//   }
// }

// Future<Map?> fetchWatchlist() async {
//   print('started');
//   DatabaseEvent event = await watchlistRef.once();
//   // print(auth.currentUser!.uid);

// // Subscribe to the stream!
//   // stream.listen((DatabaseEvent event) {
//   // print('Event Type: ${event.type}'); // DatabaseEventType.value;
//   // print('Snapshot: ${event.snapshot.value}'); // DataSnapshot
//   // if (event.snapshot != null) {
//   Map? map = event.snapshot.value as Map?;
//   // Map map2 = {};
//   // map?.forEach((key, value) {
//   keyList.clear();
//   for (DataSnapshot child in event.snapshot.children) {
//     keyList.add(child.key);
//     // print("movieid = ${map?[child.key]["movieID"]}");
//     // map2 = event.snapshot.children as Map;
//   }

//   // print(event.snapshot.children);

//   // map?.forEach((key, value) {
//   //   print('$key \t $value');
//   // });

//   // for (String item in watchlist) {
//   //   print(item);
//   // }

//   // print(event.snapshot.key);
//   // } else {
//   // print("Nothing saved");
//   // }
//   // String x = "hello";
//   // for map.forEach()
//   // print(map?["-NMfAzwU5tNv0Do4AlY5"]["movieID"]);
//   // }
//   // });
//   return map;
// }

// Future<List> fetchKeys() async {
//   print("keys being fetched");
//   DatabaseEvent event = await watchlistRef.once();
//   List keyList = [];
//   for (DataSnapshot child in event.snapshot.children) {
//     keyList.add(child.key);
//   }
//   return keyList;
// }

// addtoWatchlist(posterPath, movieID) async {
//   String user = auth.currentUser!.uid;
//   DatabaseReference watchlistRef = FirebaseDatabase.instance.ref("watchlist/$user");
//   DatabaseReference newWatchlist = watchlistRef.push();
//   // DatabaseReference watchlistRef = FirebaseDatabase.instance.ref("watchlist/${auth.currentUser!.uid}");
//   await newWatchlist.update({
//     "posterPath": posterPath,
//     "movieID": movieID,
//     "uid": auth.currentUser!.uid,
//   });
// }
