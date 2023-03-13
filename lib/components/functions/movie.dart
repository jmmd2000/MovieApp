// This class defines a Movie. This is used to take the data from the api responses and
// put it into other things such as the MovieThumbs, MoviePages etc.

class Movie {
  Movie(
    String? posterPath,
    bool? adult,
    String? overview,
    String? releaseDate,
    List<int>? genreIDs,
    int? id,
    String? title,
    String? backdropPath,
    int? voteCount,
    String? voteAverage,
    String? userRating,
  ) {
    if (posterPath != null) {
      this.posterPath = posterPath;
    }
    if (adult != null) {
      this.adult = adult;
    }
    if (overview != null) {
      this.overview = overview;
    }
    if (releaseDate != null) {
      this.releaseDate = releaseDate;
    }
    if (genreIDs != null) {
      this.genreIDs = genreIDs;
    }
    if (id != null) {
      this.id = id;
    }

    if (title != null) {
      this.title = title;
    }

    if (backdropPath != null) {
      this.backdropPath = backdropPath;
    }

    if (voteCount != null) {
      this.voteCount = voteCount;
    }

    if (voteAverage != null) {
      this.voteAverage = voteAverage;
    }
    if (userRating != null) {
      this.userRating = userRating;
    }
  }

  String? posterPath;
  bool? adult;
  String? overview;
  String? releaseDate;
  List<int>? genreIDs;
  int? id;
  String? title;
  String? backdropPath;
  int? voteCount;
  String? voteAverage;
  String? userRating;
}
