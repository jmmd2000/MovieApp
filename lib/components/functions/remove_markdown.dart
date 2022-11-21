String removeMarkdown(input) {
  String output = input;
  List issues = ["*", "_", "|", "<em>", "</em>"];

  for (String issue in issues) {
    output = output.replaceAll(issue, "");
  }

  return output;
}
