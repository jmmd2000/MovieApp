// This code contains functions that perform various operations on the
// Firebase database:
// Store user details
// Add to, delete from, and fetch the user watchlist
// Add to, delete from, update and fetch the user ratings

import 'package:api/components/functions/check_if_rated.dart';
import 'package:api/components/functions/movie.dart';
import 'package:api/components/movie/movie_thumb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth.dart';

import 'package:api/main.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

void storeUser() {
  var user = <String, dynamic>{
    "name": auth.currentUser!.displayName,
    "image": auth.currentUser!.photoURL,
    "uid": auth.currentUser!.uid,
  };

  db.collection("users").where("uid", isEqualTo: auth.currentUser!.uid).get().then((snapshot) {
    if (snapshot.size < 1) {
      db.collection("users").add(user).then((DocumentReference doc) => {});
    }
  });
}

Future<bool> deleteFromWatchlist(id) async {
  try {
    var entry = db.collection('watchlist').where('id', isEqualTo: id);
    entry.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  } catch (error) {
    return false;
  } finally {
    watchList.removeWhere((movieThumb) => movieThumb.movie.id == id);
    appSetup();
    // watchList = await fetchWatchlist();

    return true;
  }
}

Future<bool> addtoWatchlist(Movie movie) async {
  var m = <String, dynamic>{
    "uid": auth.currentUser!.uid,
    "posterPath": movie.posterPath,
    "adult": movie.adult,
    "overview": movie.overview,
    "releaseDate": movie.releaseDate,
    "genres": movie.genreIDs,
    "id": movie.id,
    "title": movie.title,
    "backdropPath": movie.backdropPath,
    "voteCount": movie.voteCount,
    "voteAverage": movie.voteAverage,
  };

  try {
    db.collection("watchlist").add(m).then((DocumentReference doc) => {});
  } catch (error) {
    return false;
  } finally {
    watchList.add(MovieThumb(movie: movie));
    appSetup();
    // watchList = await fetchWatchlist();
    return true;
  }
}

Future<List<MovieThumb>> fetchWatchlist() async {
  QuerySnapshot snapshot;
  List<MovieThumb> watchlist = [];

  db.collection("watchlist").where("uid", isEqualTo: auth.currentUser!.uid).get().then((snapshot) {
    print("SIZE=${snapshot.size}");
    if (snapshot.size < 1) {
      return watchlist;
    } else {
      snapshot.docs.forEach((doc) {
        String s = checkIfRated(doc['id'].toString(), ratingsList);
        Movie m = Movie(doc['posterPath'], doc['adult'], doc['overview'], doc['releaseDate'], doc['genres'].cast<int>(), doc['id'], doc['title'], doc['backdropPath'], doc['voteCount'],
            doc['voteAverage'].toString(), s);
        watchlist.add(MovieThumb(
          movie: m,
        ));
      });
    }
  }, onError: (e) => {});

  return watchlist;
}

Future<bool> addtoRatings(movie, userRating, Function onSwap) async {
  var m = <String, dynamic>{
    "uid": auth.currentUser!.uid,
    "rating": userRating,
    "posterPath": movie.posterPath,
    "adult": movie.adult,
    "overview": movie.overview,
    "releaseDate": movie.releaseDate,
    "genres": movie.genreIDs,
    "id": movie.id,
    "title": movie.title,
    "backdropPath": movie.backdropPath,
    "voteCount": movie.voteCount,
    "voteAverage": movie.voteAverage,
  };

  try {
    db.collection("ratings").add(m).then((DocumentReference doc) {});
  } catch (error) {
    return false;
  }
  appSetup();

  // ratingsList = await fetchRatings();

  return true;
}

Future<bool> updateRatings(movie, userRating) async {
  try {
    var docRef = db.collection("ratings").where("id", isEqualTo: movie.id).get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({"rating": userRating});
      });
    });
  } catch (error) {
    return false;
  }
  appSetup();

  // ratingsList = await fetchRatings();
  return true;
}

Future<bool> deleteFromRatings(id) async {
  try {
    var entry = db.collection('ratings').where('id', isEqualTo: id);
    entry.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  } catch (error) {
    return false;
  } finally {
    ratingsList.removeWhere((element) => element.movie.id == id);
    appSetup();

    // ratingsList = await fetchRatings();

    return true;
  }
}

Future<List<MovieThumb>> fetchRatings() async {
  QuerySnapshot snapshot;
  List<MovieThumb> ratings = [];
  db.collection("ratings").where("uid", isEqualTo: auth.currentUser!.uid).get().then((snapshot) {
    if (snapshot.size < 1) {
      return ratings;
    } else {
      snapshot.docs.forEach((doc) {
        var d = doc.data();
        Movie m = Movie(
          d['posterPath'],
          d['adult'],
          d['overview'],
          d['releaseDate'],
          d['genres'].cast<int>(),
          d['id'],
          d['title'],
          d['backdropPath'],
          d['voteCount'],
          d['voteAverage'].toString(),
          d['rating'].toString(),
        );
        ratings.add(MovieThumb(
          movie: m,
        ));

        ratings.forEach((element) {});
      });
      return ratings;
    }
  }, onError: (e) => {});

  ratings.forEach((element) {});
  return ratings;
}
