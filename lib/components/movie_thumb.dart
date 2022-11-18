import 'package:flutter/material.dart';
import '../components/movie_page.dart';
import '../colours.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class MovieThumb extends StatefulWidget {
  final String posterPath;
  final String rating;
  final String movieId;
  const MovieThumb(
      {super.key,
      required this.posterPath,
      required this.rating,
      required this.movieId});

  @override
  State<MovieThumb> createState() => _MovieThumbState();
}

class _MovieThumbState extends State<MovieThumb> {
  // late String posterPath;
  // late String rating;
  // late String movieId;
  _MovieThumbState();
  // _MovieThumbState(this.posterPath, this.rating, this.movieId);

  @override
  Widget build(BuildContext context) {
    // return const SizedBox(
    //   height: 200,
    //   width: 150,
    //   child: Text("test"),
    // );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MoviePage(
                    api:
                        'https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=21cc517d0bad572120d1663613b3a1a7&language=en-US',
                  )),
        );
      },
      child: Card(
        // semanticContainer: true,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        // shadowColor: Colors.blue,
        // margin: EdgeInsets.all(5),
        // child: Center(child: Text("${resultItem['title']}")),
        child: Center(
          child: Stack(children: [
            // Text('${resultItem['title']}'),
            Image.network(
              'https://image.tmdb.org/t/p/w500${widget.posterPath}',
              height: 172,
              width: 120,
              fit: BoxFit.cover,
              // width: 150,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    color: secondaryColour
                        .withOpacity(0.9)), //here i want to add opacity

                child: Text(widget.rating),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
