// These are the dialogs that appear when a user adds, updates or deletes a
// movie from their watchlist or ratings

import 'package:api/colours.dart';
import 'package:api/components/functions/db.dart';
import 'package:api/components/functions/movie.dart';
import 'package:flutter/material.dart';

Map ratingDialog(BuildContext context, Function callback, Movie movie, bool updateOrRate, Function onSwap, Function updatePage) {
  final TextEditingController textController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map snackbarMessage = {};
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: primaryColour,
      insetPadding: const EdgeInsets.all(0),
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: textController,
                onFieldSubmitted: (value) {},
                decoration: InputDecoration(
                  hintText: "Enter your rating...",
                  hintStyle: const TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: secondaryColour)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: secondaryColour)),
                ),
                validator: (String? value) {
                  double d = 0.0;
                  if (isANumber(value!)) {
                    d = double.parse(value);
                  }
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  } else if (!isANumber(value)) {
                    return 'Please enter a valid number';
                  } else if (d < 0 || d > 10) {
                    return 'Must be a valid number between 0 and 10';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      updateOrRate ? addtoRatings(movie, textController.text, onSwap, updatePage) : updateRatings(movie, textController.text, updatePage);
                      updateOrRate ? onSwap() : null;
                      updateOrRate ? snackbarMessage = {"rating": textController.text, "updateOrRate": 1} : snackbarMessage = {"rating": textController.text, "updateOrRate": 2};

                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  return snackbarMessage;
}

optionDialog(BuildContext context, Function callback, Movie movie, Function onSwap, Function updatePage) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: primaryColour,
      insetPadding: const EdgeInsets.all(0),
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Form(
          key: formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ratingDialog(context, callback, movie, false, onSwap, updatePage);
                  },
                  child: const Text('Update'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    deleteDialog(context, movie, onSwap);
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

deleteDialog(BuildContext context, Movie movie, Function onSwap) {
  final TextEditingController textController = TextEditingController();

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: primaryColour,
      insetPadding: const EdgeInsets.all(0),
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Form(
          child: SizedBox(
            height: 88,
            child: Column(
              children: [
                const Text(
                  "Are you sure you want to delete?",
                  style: TextStyle(color: fontPrimary, fontSize: 18),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          deleteFromRatings(movie.id);
                          Navigator.pop(context);
                          onSwap();
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                        child: const Text('Yes'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

bool isANumber(String s) {
  if (double.tryParse(s) == null) {
    return false;
  } else {
    return true;
  }
}
