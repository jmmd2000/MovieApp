// This is the login screen. It contains a welcome message and
// a "Sign in with Google" button

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:api/components/functions/auth.dart';
import 'package:api/colours.dart';

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
                        loginCheck(auth, context);
                      }
                    },
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
