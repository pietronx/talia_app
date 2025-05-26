class LinkHelper {
  static String vistaPreviaDrive(String linkOriginal) {
    final regex = RegExp(r'd/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(linkOriginal);

    if (match != null && match.groupCount >= 1) {
      final id = match.group(1);
      return "https://drive.google.com/uc?export=view&id=$id";
    } else {
      return linkOriginal;
    }
  }
}