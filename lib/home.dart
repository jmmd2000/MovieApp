import 'package:api/colours.dart';
import 'package:api/pages/discover_page.dart';
import 'package:api/pages/saved_page.dart';
import 'package:api/pages/search_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'components/functions/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int currentIndex = 0;
  // final screens = [
  //   const DiscoverPage(),
  //   const SavedPage(),
  //   // const LoginPage(),
  // ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text("greeting"),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => SearchPage(
      //                     api: 'https://api.themoviedb.org/3/search/movie?language=en-US&query={...}&page={*}&include_adult=false&api_key=21cc517d0bad572120d1663613b3a1a7',
      //                   )),
      //         );
      //       },
      //       icon: const Icon(
      //         Icons.search,
      //         color: Colors.white,
      //         size: 28,
      //       ),
      //       color: Colors.white,
      //       highlightColor: Colors.white,
      //     )
      //   ],
      // ),
      body: Text(
        "What are you doing here",
        style: TextStyle(color: Colors.white),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   onTap: (index) {
      //     setState(
      //       () {
      //         currentIndex = index;
      //       },
      //     );
      //     // dispose();
      //   },
      //   backgroundColor: primaryColour,
      //   selectedItemColor: secondaryColour,
      //   unselectedItemColor: secondaryDarker,
      //   showUnselectedLabels: false,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.explore),
      //       label: "Discover",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: "Saved",
      //     ),
      //   ],
      // ),
      // drawer: Drawer(
      //   child: drawerNavigation(context),
      // ),
    );
    // MaterialApp(
    //   // title: 'RateFlix',
    //   // theme: ThemeData(
    //   //   colorScheme: ColorScheme.fromSwatch().copyWith(
    //   //     primary: primaryColour,
    //   //     secondary: secondaryColour,
    //   //   ),
    //   //   scaffoldBackgroundColor: bodyBackground,
    //   //   canvasColor: primaryColour,
    //   // ),
    //   home:
    // ),
  }
}
