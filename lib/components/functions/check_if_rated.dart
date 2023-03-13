// This function takes a movie's ID and checks if a certain list (watchlist or ratings list) contains it
String checkIfRated(movieID, list) {
  String answer = "";
  list.forEach((item) {
    if (item.movie.id.toString() == movieID.toString()) {
      answer = item.movie.userRating.toString();
    }
  });

  return answer;
}
