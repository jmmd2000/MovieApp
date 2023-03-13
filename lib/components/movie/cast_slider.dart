// This is the same thing as the MovieSlider but using the cast information
// inside CastProfile widgets.

import 'dart:async';
import 'dart:convert';
import 'package:api/components/movie/cast_profile.dart';
import 'package:flutter/material.dart';
import 'package:api/colours.dart';

class CastSlider extends StatefulWidget {
  final String sliderTitle;
  late Future<String>? futureCast;

  CastSlider({
    super.key,
    required this.futureCast,
    required this.sliderTitle,
  });

  @override
  State<CastSlider> createState() => _CastSliderState();
}

class _CastSliderState extends State<CastSlider> {
  double xPos = 0.0;
  double screenWidth = 0;
  final controller = ScrollController(initialScrollOffset: 10);

  _CastSliderState();

  @override
  void initState() {
    super.initState();
    xPos = 0.0;
    screenWidth = 0;
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.removeListener(onScroll);
    super.dispose();
  }

  onScroll() {
    setState(() {
      // Get the minimum and maximum values for controller.offset
      // Get it as a percentage and multiply that by the screenwidth - 10
      // -10 because the divider design has an indent at start and end = 10,
      // we can set the inital value of the offset but we cant set a max value so we do it this way
      xPos = (controller.offset / controller.position.maxScrollExtent) * (screenWidth - 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: buildFromAPI(),
    );
  }

  Widget buildFromAPI() {
    return FutureBuilder<String>(
      future: widget.futureCast,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map castDetails = json.decode(snapshot.data!);
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15, bottom: 5),
                    child: Text(
                      widget.sliderTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        child: Divider(
                          color: secondaryColour,
                          indent: 10,
                          endIndent: 10,
                          thickness: 2,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: xPos,
                        child: Container(
                          height: 6,
                          width: 10,
                          decoration: BoxDecoration(
                            color: secondaryColour,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: lengthCheck(castDetails['cast'].length),
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  itemBuilder: (BuildContext c, int i) {
                    Map resultItem = castDetails['cast'][i]!;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CastProfile(
                        name: resultItem['name'].toString(),
                        profilePath: resultItem['profile_path'].toString(),
                        role: resultItem['character'].toString(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(
              color: secondaryDarker,
              backgroundColor: secondaryColour,
            ),
          ),
        );
      },
    );
  }

  int lengthCheck(length) {
    if (length < 15) {
      return length;
    } else {
      return 15;
    }
  }
}
