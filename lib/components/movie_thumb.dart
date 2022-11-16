import 'package:flutter/material.dart';
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
  // required this.posterPath,
  // required this.rating,
  // required this.movieId});

  @override
  State<MovieThumb> createState() => _MovieThumbState();
  // _MovieThumbState(posterPath, rating, movieId);

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
        // const snackBar = SnackBar(content: Text('$this.movieId'));

        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Card(
        // semanticContainer: true,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        // shadowColor: Colors.blue,
        // margin: EdgeInsets.all(5),
        // child: Center(child: Text("${resultItem['title']}")),
        child: Center(
          child: Column(children: [
            // Text('${resultItem['title']}'),
            Image.network(
              'https://image.tmdb.org/t/p/w500${widget.posterPath}',
              height: 172,
              width: 120,
              fit: BoxFit.cover,
              // width: 150,
            ),
            // Text(rating),
            // Text(movieId),
          ]),
        ),
      ),
    );
  }
}
