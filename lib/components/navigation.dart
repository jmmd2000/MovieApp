// This is the sidebar navigation and contains the links to the different screens:
// • Discover Page
// • Ratings Page
// • Watchlist Page
// • Showtimes Page

import 'package:api/pages/saved_page.dart';
import 'package:api/pages/showtimes.dart';
import 'package:flutter/material.dart';
import 'package:api/colours.dart';
import 'package:api/pages/discover_page.dart';
import 'package:api/pages/ratings_page.dart';
import 'package:api/pages/search_page.dart';
import 'functions/auth.dart';

Widget drawerNavigation(BuildContext context) {
  var list = Column(
    children: [
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            color: primaryColour,
            child: GestureDetector(
              onTap: () {},
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
          ),
          ListTile(
            leading: Icon(
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
            leading: Icon(
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
            },
          ),
          ListTile(
            leading: Icon(
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
                  builder: (context) => const RatingPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
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
                  builder: (context) => const ShowtimePage(),
                ),
              );
            },
          ),
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
        MaterialPageRoute(builder: (context) => SearchPage()),
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
