import 'package:api/components/functions/db.dart';
import 'package:api/pages/saved_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colours.dart';
import '../pages/discover_page.dart';
import '../pages/search_page.dart';
import 'functions/auth.dart';
import 'functions/get_image.dart';
import 'movie/movie_thumb.dart';

Widget drawerNavigation(BuildContext context) {
  var list =
      // ListView(
      //   children: <Widget>[
      //     Text(
      //       "Discover",
      //     ),
      //     ListTile(
      //       leading: Icon(Icons.explore),
      //       title: Text("Discover ", textDirection: TextDirection.rtl),
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => DiscoverPage(),
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // );
      Column(
    children: [
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            color: primaryColour,
            child: DrawerHeader(
              decoration: BoxDecoration(
                border: Border(
                  bottom: Divider.createBorderSide(context, color: secondaryColour, width: 1.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(auth.currentUser!.photoURL.toString()),
                      backgroundColor: secondaryColour,
                      radius: 45,
                    ),
                  ),
                  Text(
                    "${auth.currentUser!.displayName}",
                    style: const TextStyle(color: fontPrimary, fontSize: 22),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.explore,
              color: secondaryColour,
            ),
            title: const Text(
              "Discover ",
              textAlign: TextAlign.left,
              style: TextStyle(color: fontPrimary),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DiscoverPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.checklist,
              color: secondaryColour,
            ),
            title: const Text(
              "Watchlist ",
              textAlign: TextAlign.left,
              style: TextStyle(color: fontPrimary),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedPage(),
                ),
              );
              // fetchWatchlist();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.thumbs_up_down,
              color: secondaryColour,
            ),
            title: const Text(
              "Ratings",
              textAlign: TextAlign.left,
              style: TextStyle(color: fontPrimary),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DiscoverPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.theaters,
              color: secondaryColour,
            ),
            title: const Text(
              "Showtimes",
              textAlign: TextAlign.left,
              style: TextStyle(color: fontPrimary),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DiscoverPage(),
                ),
              );
            },
          ),
          // Spacer(),

          // Container(
          //   color: primaryColour,
          //   child: Column(children: [

          //   ]),
          // )
        ],
      ),
      const Spacer(),
      Container(
        color: secondaryColour,
        child: ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          title: const Text(
            "Sign out",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            signOut(context: context, user: auth.currentUser);
          },
        ),
      ),
    ],
  );
  return list;
}

IconButton searchButton(BuildContext context) {
  var button = IconButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchPage(
                  api: 'https://api.themoviedb.org/3/search/movie?language=en-US&query={...}&page={*}&include_adult=false&api_key=21cc517d0bad572120d1663613b3a1a7',
                )),
      );
    },
    icon: const Icon(
      Icons.search,
      color: Colors.white,
      size: 28,
    ),
    color: Colors.white,
    highlightColor: Colors.white,
  );
  return button;
}
