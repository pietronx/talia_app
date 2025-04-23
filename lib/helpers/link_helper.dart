import 'dart:convert';
import 'package:http/http.dart' as http;

class LinkHelper {
  /// Convierte un enlace estándar de Drive en uno directo (útil para imágenes)
  static String linkDrive(String linkOriginal) {
    final regex = RegExp(r'd/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(linkOriginal);

    if (match != null && match.groupCount >= 1) {
      final id = match.group(1);
      return "https://drive.google.com/uc?export=view&id=$id";
    } else {
      return linkOriginal;
    }
  }

  /// Descarga el contenido de un archivo .txt en Drive como texto
  static Future<String> descriptionDrive(String driveLink) async {
    final url = linkDrive(driveLink); // usamos el método anterior
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      throw Exception("No se pudo cargar la descripción");
    }
  }

  static Future<(String titulo, String subtitulo)> cargarTituloYSubtitulo(String driveLink) async {
    final url = linkDrive(driveLink);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final contenido = utf8.decode(response.bodyBytes);
      final lineas = contenido.trim().split('\n');
      final titulo = lineas.isNotEmpty ? lineas[0].trim() : "Sin título";
      final subtitulo = lineas.length > 1 ? lineas[1].trim() : "";
      return (titulo, subtitulo);
    } else {
      throw Exception("No se pudo cargar el archivo de título");
    }
  }


  static String vistaPreviaDrive(String linkOriginal) {
    final regex = RegExp(r'd/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(linkOriginal);

    if (match != null && match.groupCount >= 1) {
      final id = match.group(1);
      return "https://drive.google.com/file/d/$id/preview";
    } else {
      return linkOriginal;
    }
  }


}