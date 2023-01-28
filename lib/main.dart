// import 'package:api/home.dart';
import 'package:api/home.dart';
import 'package:api/pages/discover_page.dart';
import 'package:api/pages/login_page.dart';
// import 'package:api/pages/saved_page.dart';
// import 'package:api/pages/discover_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'colours.dart';
import 'colours.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'components/functions/db.dart';
import 'components/functions/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "RateFlix",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const App());
  runApp(
    MaterialApp(
      home: const App(),
      title: 'RateFlix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColour,
          secondary: secondaryColour,
        ),
        scaffoldBackgroundColor: bodyBackground,
        canvasColor: primaryColour,
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
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? const DiscoverPage() : const LoginPage();
    // return const MaterialApp(
    //   title: 'RateFlix',
    //   // theme: ThemeData(
    //   //   primarySwatch: Colors.blue,
    //   // ),
    //   // home: LoginPage(),
    //   home: HomePage(),
    // );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<User>(
  //       future: auth.currentUser,
  //       builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
  //         if (snapshot.hasData) {
  //           User? user = snapshot.data; // this is your user instance
  //           /// is because there is user already logged
  //           return const HomePage();
  //         }

  //         /// other way there is no user logged.
  //         return const LoginPage();
  //       });
  // }
}

// DISCOVER PAGE


