// ignore_for_file: prefer_const_constructors

import 'package:api/components/functions/auth.dart';
import 'package:flutter/material.dart';
// import '../colours.dart';
import 'package:api/main.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signOut(context: context, user: auth.currentUser);
            // if (user != null) {
            //   setState(() {
            //     answer = "Goodbye";
            //   });
            // } else {
            //   setState(() {
            //     answer = "error";
            //   });
            // }
          },
          child: const Text("Log out"),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
