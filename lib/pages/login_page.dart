import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../components/functions/auth.dart';
import 'package:api/main.dart';
import '../colours.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RateFlix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColour,
          secondary: secondaryColour,
        ),
        scaffoldBackgroundColor: white,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Welcome to RateFlix!'),
        //   centerTitle: true,
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'lib/assets/grid-bg.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Welcome to RateFlix!",
                style: textSecondaryBold32,
              ),
            ),
            Center(
              child: Column(
                children: [
                  SignInButton(
                    Buttons.Google,
                    text: "Sign in with Google",
                    onPressed: () async {
                      await signInWithGoogle(auth);
                      if (mounted) {
                        // print("mounted, checking login___________");
                        loginCheck(auth, context);
                      }
                    },
                  ),
                  SignInButtonBuilder(
                    backgroundColor: secondaryColour,
                    onPressed: () {},
                    text: 'Sign in as guest',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
