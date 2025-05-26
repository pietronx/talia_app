// Clase modelo para los links
class LinkHelper {
  static String vistaPreviaDrive(String linkOriginal) {
    final regex = RegExp(r'd/([a-zA-Z0-9_-]+)'); // Expresión regular para extraer el ID del enlace
    final match = regex.firstMatch(linkOriginal);

    if (match != null && match.groupCount >= 1) {
      final id = match.group(1);
      return "https://drive.google.com/uc?export=view&id=$id"; // Construir el enlace
    } else {
      return linkOriginal;
    }
  }
}