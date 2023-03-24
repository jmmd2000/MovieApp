// This is the root of the app and performs the apps setup

import 'package:api/components/functions/shared_preferences.dart';
import 'package:api/pages/discover_page.dart';
import 'package:api/pages/login_page.dart';
import 'package:api/pages/ratings_page.dart';
import 'package:api/pages/saved_page.dart';
import 'package:api/pages/search_page.dart';
import 'package:api/pages/showtimes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'colours.dart';
import 'components/movie/movie_thumb.dart';
import 'firebase_options.dart';
import 'components/functions/db.dart';

List<MovieThumb> watchList = [];
List<MovieThumb> ratingsList = [];
List<String> searchHistory = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "RateFlix",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      home: const App(),
      title: 'RateFlix',
      debugShowCheckedModeBanner: false,
      routes: {
        'Discover': (context) => const DiscoverPage(),
        'Login': (context) => const LoginPage(),
        'Ratings': (context) => const RatingPage(),
        'Watchlist': (context) => const SavedPage(),
        'Search': (context) => SearchPage(),
        'Showtimes': (context) => const ShowtimePage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColour,
          secondary: secondaryColour,
        ),
        scaffoldBackgroundColor: bodyBackground,
        canvasColor: primaryColour,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(backgroundColor: secondaryColour),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: secondaryColour),
        ),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? const DiscoverPage() : const LoginPage();
  }
}

appSetup() async {
  ratingsList = await fetchRatings();
  watchList = await fetchWatchlist();
  searchHistory = await fetchSearchHistory();
}
