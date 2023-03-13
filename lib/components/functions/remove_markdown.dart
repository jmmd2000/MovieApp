// When fetching the comment content for the movie reviews, they contain
// certain tags and characters to display certain formatting in markdown.
// This just removes those things as they do not display properly here.

String removeMarkdown(input) {
  String output = input;
  List issues = ["*", "_", "|", "<em>", "</em>"];

  for (String issue in issues) {
    output = output.replaceAll(issue, "");
  }

  return output;
}
