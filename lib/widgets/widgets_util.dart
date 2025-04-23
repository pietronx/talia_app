import 'dart:async';
import 'dart:io' show Platform;

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../helpers/link_helper.dart';

// Función para crear los recuadros con texto o imagen
class WidgetsUtil {
  // Contenedor personalizable
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
  })
  {
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
          color: textoColor ?? AppColors.texto,
          height: textHeight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget popupCard({
    required BuildContext context,
    required String titulo,
    required String imagenUrl,
    required String descripcion,
    String? subtitulo,
    String? programaUrl,
  })
  {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        WidgetsUtil.popupPersonalizado(
          context: context,
          titulo: titulo,
          descripcion: descripcion,
          imagenUrl: imagenUrl,
          programaurl: programaUrl,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // Cargar imagen
          FutureBuilder<Image>(
            future: _cargarImagen(imagenUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                // Mientras carga, muestra loader
                return Container(
                  width: screenWidth * 0.8,
                  height: screenWidth * 0.8,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }

              // Imagen cargada con sombra y bordes
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(80),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.8,
                    child: snapshot.data!,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Título y subtítulo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (subtitulo != null)
                  Text(
                    subtitulo,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Función para cargar imagen
  static Future<Image> _cargarImagen(String url) async {
    final image = Image.network(url, fit: BoxFit.cover);
    final completer = Completer<Image>();
    final imageStream = image.image.resolve(const ImageConfiguration());

    imageStream.addListener(
      ImageStreamListener(
            (info, _) => completer.complete(image),
        onError: (error, _) => completer.completeError(error),
      ),
    );

    return completer.future;
  }


  // Popup personalizable
  static void popupPersonalizado({
    required BuildContext context,
    required String descripcion,
    required String titulo,
    required String imagenUrl,
    String? programaurl,
    VoidCallback? onClose,
  })
  {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.fondo,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.75,
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 30),
                  children: [

                    // Imagen
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.network(
                        imagenUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text("No se pudo cargar la imagen"),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Titulo
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Descripción
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        descripcion,
                        style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Botones
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Botón de programa de mano
                        if (programaurl != null && programaurl.isNotEmpty)
                          ElevatedButton.icon(
                            onPressed: () {
                              final previewLink = LinkHelper.vistaPreviaDrive(programaurl);
                              OpenLink.abrirEnlace(previewLink);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            icon: const Icon(Icons.picture_as_pdf, size: 18),
                            label: const Text('Programa de Mano'),
                          ),


                        const SizedBox(width: 12),

                        // Botón de cerrar
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (onClose != null) onClose();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appbar,
                            foregroundColor: AppColors.fondo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Ayuda
  static Widget bloqueAyuda({
    IconData? icono,
    required String titulo,
    required String descripcion,
    List<String>? puntos,
  })
  {
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

  // Apartado de Copyright y Aviso Legal
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
                  OpenLink.abrirEnlace(
                    'https://www.grupotalia.org/privacidad/',
                  );
                },
                icon: const Icon(Icons.privacy_tip),
                label: const Text('Política de Privacidad'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  backgroundColor: AppColors.texto,
                  // Fondo del botón
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  OpenLink.abrirEnlace(
                    'https://www.grupotalia.org/avisolegal/',
                  );
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
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
              const SizedBox(height: 4),
              Text(
                'Todos los derechos reservados',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Grid del inicio
  static Widget gridMenu({
    required String imagePath,
    required VoidCallback onTap,
    double? height,
  })
  {
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
  })
  {
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
