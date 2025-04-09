import 'dart:io' show Platform;

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

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
    BoxFit? fit,
  }) {
    if (path != null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: fondoColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: fondoColor ?? AppColors.fondo,
        borderRadius: BorderRadius.circular(10),
        boxShadow:
            fondoColor == null
                ? []
                : [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textoColor ?? Colors.black,
          height: textHeight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget bloqueAyuda({
    IconData? icono,
    required String titulo,
    required String descripcion,
    List<String>? puntos,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icono != null) Icon(icono, size: 28, color: AppColors.appbar),
              SizedBox(width: icono != null ? 10 : 0),
              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(descripcion, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          ...(puntos ?? []).map(
            (p) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 16)),
                Expanded(child: Text(p, style: const TextStyle(fontSize: 16))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget pieDePagina() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          const Divider(
            indent: 20,
            endIndent: 20,
            thickness: 1,
            color: AppColors.drawerCabecera,
          ),

          const SizedBox(height: 10),

          // Botones legales
          Column(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  OpenLink.abrirEnlace('https://www.grupotalia.org/privacidad/');
                },
                icon: const Icon(Icons.privacy_tip),
                label: const Text('Política de Privacidad'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  backgroundColor: AppColors.texto,     // Fondo del botón
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  OpenLink.abrirEnlace('https://www.grupotalia.org/avisolegal/');
                },
                icon: const Icon(Icons.gavel),
                label: const Text('Aviso Legal'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  backgroundColor: AppColors.texto,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Derechos
          Column(
            children: [
              Text(
                '© ${DateTime.now().year} Grupo Talía',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Todos los derechos reservados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget gridMenu({
    required String imagePath,
    required VoidCallback onTap,
    double? height,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class OpenLink {
  static Widget socialMediaIcon({
    IconData? icono,
    String? path,
    required String url,
    double size = 24.0,
  }) {
    if (path != null) {
      return GestureDetector(
        onTap: () => abrirEnlace(url),
        child: Image.asset(path, width: size, height: size),
      );
    }

    return IconButton(
      icon: Icon(icono),
      onPressed: () => abrirEnlace(url),
      iconSize: size,
    );
  }

  static void abrirEnlace(String url) async {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(action: 'action_view', data: url);
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
