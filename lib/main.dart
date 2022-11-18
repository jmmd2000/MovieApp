import 'package:api/pages/saved_page.dart';
import 'package:api/pages/discover_page.dart';
import 'package:flutter/material.dart';
import 'colours.dart';
// import 'package:http/http.dart' as http;

// Future<String> fetchMovie() async {
// // Future<Movie> fetchMovie() async {
//   final response = await http.get(Uri.parse(
//       'https://api.themoviedb.org/3/movie/popular?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US&page=1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     // return Movie.fromJson(jsonDecode(response.body));
//     return response.body;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load movie');
//   }
// }

// class Movie {
//   final String poster;
//   final String backdrop;
//   final int id;
//   final String title;
//   final String blurb;

//   final String releaseDate;

//   const Movie({
//     required this.poster,
//     required this.backdrop,
//     required this.id,
//     required this.title,
//     required this.blurb,
//     required this.releaseDate,
//   });

//   factory Movie.fromJson(Map<String, dynamic> json) {
//     return Movie(
//       poster: json['poster_path'],
//       backdrop: json['backdrop_path'],
//       id: json['id'],
//       title: json['title'],
//       blurb: json['overview'],
//       releaseDate: json['release_date'],
//     );
//   }
// }

// for(var i = 0; i < result["genres"].length; i++){
//                 genresList += result["genres"][i]["name"] + " ";
//               }

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cinematica',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: MainPage(),
    );
  }
}

// DISCOVER PAGE

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    const DiscoverPage(),
    const SavedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cinematica',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: primaryColour,
            secondary: secondaryColour,
          ),
          scaffoldBackgroundColor: bodyBackground,
        ),
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text('Layout Test (Discover)'),
          //   centerTitle: true,
          // ),
          body: IndexedStack(
            // This keeps track of each screens state so that its not lost. When a
            // new screen is brought up, the other screens are removed from the widget
            // tree which removes their state
            index: currentIndex,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            backgroundColor: primaryColour,
            selectedItemColor: secondaryColour,
            unselectedItemColor: secondaryDarker,
            // selectedFontSize: 14,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: "Discover",
                // backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Saved",
                // backgroundColor: Colors.green,
              ),
            ],
          ),
        ));
  }
}
