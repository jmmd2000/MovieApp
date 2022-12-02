import 'package:api/colours.dart';
import 'package:api/pages/discover_page.dart';
import 'package:api/pages/saved_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    const DiscoverPage(),
    const SavedPage(),
    // const LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        title: 'RateFlix',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: primaryColour,
            secondary: secondaryColour,
          ),
          scaffoldBackgroundColor: bodyBackground,
        ),
        home: Scaffold(
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
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: "Discover",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Saved",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
