// This is the sort menu for the SearchPage. It allows the user to sort the results from their search
// by things like date, title and rating

import 'package:api/colours.dart';
import 'package:api/components/movie/movie_thumb.dart';
import 'package:flutter/material.dart';

class SortMenu extends StatefulWidget {
  final bool menuOpen;
  final bool textFade;
  final List<MovieThumb> list;
  final Function updateParent;
  final bool userRating;
  const SortMenu({super.key, required this.menuOpen, required this.textFade, required this.list, required this.updateParent, required this.userRating});

  @override
  State<SortMenu> createState() => _SortMenuState();
}

class _SortMenuState extends State<SortMenu> {
  int yearCount = 0;
  int ratingCount = 0;
  int titleCount = 0;
  int userRatingCount = 0;
  var ratingchipIcon;
  var titlechipIcon;
  var yearchipIcon;
  var userRatingchipIcon;
  String selectedChip = "";

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      height: widget.menuOpen ? 50 : 0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
        opacity: widget.menuOpen ? 1 : 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilterChip(
                showCheckmark: false,
                avatar: yearchipIcon,
                label: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.ease,
                  opacity: widget.menuOpen ? 1 : 0,
                  child: Text(
                    'Year',
                    style: textPrimary,
                  ),
                ),
                onSelected: (bool selected) {
                  setState(() {
                    titlechipIcon = null;
                    titleCount = 0;
                    ratingchipIcon = null;
                    ratingCount = 0;
                    userRatingchipIcon = null;
                    userRatingCount = 0;
                    switch (yearCount) {
                      // Inactive
                      case 0:
                        selectedChip = "year";
                        yearchipIcon = const Icon(
                          Icons.north,
                          color: Colors.white,
                        );
                        widget.list.sort((a, b) => a.movie.releaseDate!.compareTo(b.movie.releaseDate!));
                        widget.updateParent();
                        yearCount++;
                        break;
                      // Active ascending
                      case 1:
                        selectedChip = "year";
                        yearchipIcon = const Icon(
                          Icons.south,
                          color: Colors.white,
                        );
                        widget.list.sort((a, b) => b.movie.releaseDate!.compareTo(a.movie.releaseDate!));
                        widget.updateParent();
                        yearCount++;
                        break;
                      // Active descending
                      case 2:
                        selectedChip = "";
                        yearchipIcon = null;
                        yearCount = 0;
                        break;
                      default:
                    }
                  });
                },
                selected: selectedChip == "year",
                backgroundColor: bodyBackground,
                side: BorderSide(color: secondaryColour),
                selectedColor: secondaryColour,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilterChip(
                showCheckmark: false,
                avatar: titlechipIcon,
                label: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.ease,
                  opacity: widget.menuOpen ? 1 : 0,
                  child: Text(
                    'Title',
                    style: textPrimary,
                  ),
                ),
                onSelected: (bool selected) {
                  setState(() {
                    yearchipIcon = null;
                    yearCount = 0;
                    ratingchipIcon = null;
                    ratingCount = 0;
                    userRatingchipIcon = null;
                    userRatingCount = 0;
                    switch (titleCount) {
                      // Inactive
                      case 0:
                        selectedChip = "title";
                        titlechipIcon = const Icon(
                          Icons.north,
                          color: Colors.white,
                        );
                        widget.list.sort((a, b) => a.movie.title!.compareTo(b.movie.title!));
                        widget.updateParent();
                        titleCount++;
                        break;
                      // Active ascending
                      case 1:
                        selectedChip = "title";
                        titlechipIcon = const Icon(
                          Icons.south,
                          color: Colors.white,
                        );
                        widget.list.sort((a, b) => b.movie.title!.compareTo(a.movie.title!));
                        widget.updateParent();
                        titleCount++;
                        break;
                      // Active descending
                      case 2:
                        selectedChip = "";
                        titlechipIcon = null;
                        titleCount = 0;
                        break;
                      default:
                    }
                  });
                },
                selected: selectedChip == "title",
                backgroundColor: bodyBackground,
                side: BorderSide(color: secondaryColour),
                selectedColor: secondaryColour,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilterChip(
                showCheckmark: false,
                avatar: ratingchipIcon,
                label: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.ease,
                  opacity: widget.menuOpen ? 1 : 0,
                  child: Text(
                    'Rating',
                    style: textPrimary,
                  ),
                ),
                onSelected: (bool selected) {
                  setState(() {
                    titlechipIcon = null;
                    titleCount = 0;
                    yearchipIcon = null;
                    yearCount = 0;
                    userRatingchipIcon = null;
                    userRatingCount = 0;
                    switch (ratingCount) {
                      // Inactive
                      case 0:
                        selectedChip = "rating";
                        ratingchipIcon = const Icon(
                          Icons.north,
                          color: Colors.white,
                        );
                        widget.list.sort((a, b) => a.movie.voteAverage!.compareTo(b.movie.voteAverage!));
                        widget.updateParent();
                        ratingCount++;
                        break;
                      // Active ascending
                      case 1:
                        selectedChip = "rating";
                        ratingchipIcon = const Icon(
                          Icons.south,
                          color: Colors.white,
                        );
                        widget.list.sort((a, b) => b.movie.voteAverage!.compareTo(a.movie.voteAverage!));
                        widget.updateParent();
                        ratingCount++;
                        break;
                      // Active descending
                      case 2:
                        selectedChip = "";
                        ratingchipIcon = null;
                        ratingCount = 0;
                        break;
                      default:
                    }
                  });
                },
                selected: selectedChip == "rating",
                backgroundColor: bodyBackground,
                side: BorderSide(color: secondaryColour),
                selectedColor: secondaryColour,
              ),
            ),
            widget.userRating
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      showCheckmark: false,
                      avatar: userRatingchipIcon,
                      label: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.ease,
                        opacity: widget.menuOpen ? 1 : 0,
                        child: Text(
                          'Your Rating',
                          style: textPrimary,
                        ),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          titlechipIcon = null;
                          titleCount = 0;
                          yearchipIcon = null;
                          yearCount = 0;
                          ratingchipIcon = null;
                          ratingCount = 0;
                          switch (userRatingCount) {
                            // Inactive
                            case 0:
                              selectedChip = "userrating";
                              userRatingchipIcon = const Icon(
                                Icons.north,
                                color: Colors.white,
                              );
                              widget.list.sort((a, b) => a.movie.userRating!.compareTo(b.movie.userRating!));
                              widget.updateParent();
                              userRatingCount++;
                              break;
                            // Active ascending
                            case 1:
                              selectedChip = "userrating";
                              userRatingchipIcon = const Icon(
                                Icons.south,
                                color: Colors.white,
                              );
                              widget.list.sort((a, b) => b.movie.userRating!.compareTo(a.movie.userRating!));
                              widget.updateParent();
                              userRatingCount++;
                              break;
                            // Active descending
                            case 2:
                              selectedChip = "";
                              userRatingchipIcon = null;
                              userRatingCount = 0;
                              break;
                            default:
                          }
                        });
                      },
                      selected: selectedChip == "userrating",
                      backgroundColor: bodyBackground,
                      side: BorderSide(color: secondaryColour),
                      selectedColor: secondaryColour,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
