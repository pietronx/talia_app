import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../customColors/app_colors.dart';

// Función para crear los recuadros con texto o imagen
class WidgetsUtil {
  static Widget contenedorPersonalizado({
    double? width,
    double? height,
    String? text,
    String? path,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    double? textHeight, // Interlineado
    Color? fondoColor,
    Color? textoColor,
  }) {
    // Si se proporciona una ruta de imagen
    if (path != null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: fondoColor ?? Colors.transparent,
          // Color de fondo opcional
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        ),
      );
    }

    // Si no se proporciona ruta de imagen, se muestra el texto
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: fondoColor ?? AppColors.fondo,
        borderRadius: BorderRadius.circular(10),
        // Eliminar las sombras si no se pasa el fondoColor
        boxShadow:
            fondoColor == null
                ? [] // Sin sombra si no hay fondoColor
                : [
                  BoxShadow(
                    color: Colors.black.withAlpha(
                      100,
                    ), // Opacidad del sombreado
                    blurRadius: 10, // Difuminación del sombreado
                    spreadRadius: 2, // Tamaño del sombreado
                    offset: const Offset(0, 2), // Desplazamiento del sombreado
                  ),
                ],
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textoColor ?? Colors.black,
          height: textHeight, // Interlineado si se pasa
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Función para crear los iconos de redes sociales
class OpenLink {
  static Widget socialMediaIcon({

    IconData? icono, // Icono de Flutter (opcional)
    String? path, // Ruta del icono desde los assets (opcional)
    required String url, // URL que abrirá el enlace
    Color color = AppColors.appbar, // Color para el icono o imagen
    double size = 24.0, // Tamaño del icono o imagen

  }) {
    // Si se proporciona una ruta de imagen (assets), usar esa imagen
    if (path != null) {
      return GestureDetector(
        onTap: () => abrirEnlace(url),
        child: Image.asset(
          path,
          width: size,
          height: size,
          color: color, // El color solo se aplica si la imagen lo soporta
        ),
      );
    }

    // Si se pasa un icono de Flutter, usar el IconButton
    return IconButton(
      icon: Icon(icono, color: color),
      onPressed: () => abrirEnlace(url),
      iconSize: size,
    );
  }

// Función privada para abrir enlaces en Android con android_intent_plus
  static void abrirEnlace(String url) async {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'action_view',
        data: url,
      );
      try {
        await intent.launch();
      } catch (e) {
        debugPrint('Error al intentar abrir el enlace: $e');
      }
    } else {
      debugPrint('Este método solo funciona en Android por ahora');
    }
  }
}
