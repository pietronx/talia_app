import 'dart:async';
import 'dart:io' show Platform;

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../customColors/app_colors.dart';
import '../helpers/link_helper.dart';
import '../models/news_model.dart';
import '../models/next_events_model.dart';

class WidgetsUtil {
  static Widget contenedorPersonalizado({
    double? width,
    double? height,
    String? text,
    String? path,
    double? fontSize,
    FontWeight fontWeight = FontWeight.normal,
    double? textHeight,
    Color? fondoColor,
    Color? textoColor,
    BoxFit? fit,
  }) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        final resolvedWidth = width ?? screenWidth * 0.8;
        final resolvedHeight = height ?? screenHeight * 0.1;
        final resolvedFontSize = fontSize ?? screenWidth * 0.045;

        if (path != null) {
          return Container(
            width: resolvedWidth,
            height: resolvedHeight,
            decoration: BoxDecoration(
              color: fondoColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(path),
                fit: fit ?? BoxFit.cover,
              ),
            ),
          );
        }

        return Container(
          padding: EdgeInsets.all(screenWidth * 0.025),
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
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
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: resolvedFontSize,
              fontWeight: fontWeight,
              color: textoColor ?? AppColors.texto,
              height: textHeight,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

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

  static Widget tarjetaAnteriorEvento({
    required BuildContext context,
    required String titulo,
    required String imagenUrl,
    required String descripcion,
    String? subtitulo,
    String? programaUrl,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardSize = screenWidth * 0.8;
    final titleFontSize = screenWidth * 0.045;
    final subtitleFontSize = screenWidth * 0.04;

    final previewLink = LinkHelper.vistaPreviaDrive(imagenUrl);

    return GestureDetector(
      onTap: () {
        WidgetsUtil.mostrarDetallesAnteriorEvento(
          context: context,
          titulo: titulo,
          descripcion: descripcion,
          imagenUrl: previewLink,
          programaurl: programaUrl,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<Image>(
            future: _cargarImagen(previewLink),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return SizedBox(
                  width: cardSize,
                  height: cardSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/animations/loading_card.json',
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.2,
                        repeat: true,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Cargando evento...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.hasError || snapshot.data == null) {
                return Container(
                  width: cardSize,
                  height: cardSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(80),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: Colors.grey,
                  ),
                );
              }

              return Column(
                children: [
                  Container(
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
                        width: cardSize,
                        height: cardSize,
                        child: snapshot.data!,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                    ),
                    child: Column(
                      children: [
                        Text(
                          titulo,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitulo != null && subtitulo.trim().isNotEmpty)
                          Text(
                            subtitulo,
                            style: TextStyle(
                              fontSize: subtitleFontSize,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  static void mostrarDetallesAnteriorEvento({
    required BuildContext context,
    required String descripcion,
    required String titulo,
    required String imagenUrl,
    String? programaurl,
    VoidCallback? onClose,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final titleFontSize = screenWidth * 0.06;
    final bodyFontSize = screenWidth * 0.04;
    final paddingHorizontal = screenWidth * 0.06;
    final spacing = screenHeight * 0.01;

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
            padding: EdgeInsets.only(bottom: spacing),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: screenHeight * 0.75),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: spacing * 1.5),
                  children: [
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

                    SizedBox(height: spacing * 1.5),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal,
                      ),
                      child: Text(
                        titulo,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    SizedBox(height: spacing * 1),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal,
                      ),
                      child: Text(
                        descripcion,
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          color: Colors.grey[900],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    SizedBox(height: spacing * 1.2),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (programaurl != null && programaurl.isNotEmpty)
                          ElevatedButton.icon(
                            onPressed: () {
                              final previewLink = LinkHelper.vistaPreviaDrive(
                                programaurl,
                              );
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
                            label: Text(
                              'Programa de Mano',
                              style: TextStyle(fontSize: bodyFontSize),
                            ),
                          ),

                        SizedBox(height: spacing - 0.9),

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
                          child: Text(
                            'Cerrar',
                            style: TextStyle(fontSize: bodyFontSize),
                          ),
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

  static Widget tarjetaProximoEvento({
    required BuildContext context,
    required int index,
    required ProximoEvento evento,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardSize = screenWidth * 0.8;
    final titleFontSize = screenWidth * 0.050;
    final subtitleFontSize = screenWidth * 0.05;
    final spacing = screenHeight * 0.025;

    final previewLink = LinkHelper.vistaPreviaDrive(evento.portadaUrl);

    return FutureBuilder<Image>(
      future: _cargarImagen(previewLink),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            width: cardSize,
            height: cardSize,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/loading_card.json',
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.2,
                  repeat: true,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Cargando evento...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 50, color: Colors.grey),
              SizedBox(height: spacing),
              Text(
                "Sin conexión",
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: Colors.grey,
                ),
              ),
            ],
          );
        }

        return GestureDetector(
          onTap: () {
            WidgetsUtil.mostrarDetallesProximoEvento(
              context: context,
              evento: evento,
            );
          },
          child: Column(
            children: [
              Container(
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
                    width: cardSize,
                    height: cardSize,
                    child: snapshot.data!,
                  ),
                ),
              ),
              SizedBox(height: spacing),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Column(
                  children: [
                    Text(
                      evento.titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (evento.subtitulo.trim().isNotEmpty)
                      Text(
                        evento.subtitulo,
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void mostrarDetallesProximoEvento({
    required BuildContext context,
    required ProximoEvento evento,
  }) {
    final previewLink = LinkHelper.vistaPreviaDrive(evento.portadaUrl);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final titleFontSize = screenWidth * 0.055;
    final subtitleFontSize = screenWidth * 0.04;
    final descriptionFontSize = screenWidth * 0.04;
    final spacing = screenHeight * 0.02;
    final horizontalPadding = screenWidth * 0.06;

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
            padding: EdgeInsets.only(bottom: spacing),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: screenHeight * 0.8),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: spacing * 1.5),
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.network(
                        previewLink,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, _) {
                          return const Center(
                            child: Text("No se pudo cargar la imagen"),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: spacing * 1.25),


                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Text(
                        evento.titulo,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    SizedBox(height: spacing * 0.75),


                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Text(
                        '${evento.fecha} — ${evento.lugar}',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    SizedBox(height: spacing),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Text(
                        evento.descripcion,
                        style: TextStyle(
                          fontSize: descriptionFontSize,
                          color: Colors.grey[900],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    SizedBox(height: spacing * 1.25),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (evento.linkEntradas != null)
                          ElevatedButton.icon(
                            onPressed:
                                () =>
                                    OpenLink.abrirEnlace(evento.linkEntradas!),
                            icon: const Icon(Icons.shopping_cart),
                            label: Text(
                              'Comprar Entradas',
                              style: TextStyle(fontSize: subtitleFontSize),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.titulo,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),

                        if (evento.linkMasInfo != null)
                          ElevatedButton.icon(
                            onPressed:
                                () => OpenLink.abrirEnlace(evento.linkMasInfo!),
                            icon: const Icon(Icons.info_outline),
                            label: Text(
                              'Más Información',
                              style: TextStyle(fontSize: subtitleFontSize),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey[800],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),

                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appbar,
                            foregroundColor: AppColors.fondo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            'Cerrar',
                            style: TextStyle(fontSize: subtitleFontSize),
                          ),
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

  static Widget tarjetaNoticia({
    required BuildContext context,
    required int index,
    required Noticia noticia,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = screenWidth * 0.9;
    final cardHeight = screenWidth * 0.5;
    final titleFontSize = screenWidth * 0.05;
    final descriptionFontSize = screenWidth * 0.04;
    final leerMasFontSize = screenWidth * 0.05;
    final dateFontSize = screenWidth * 0.04;
    final spacing = screenHeight * 0.02;

    final previewLink = LinkHelper.vistaPreviaDrive(noticia.portadaUrl);

    return FutureBuilder<Image>(
      future: _cargarImagen(previewLink),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: cardWidth,
            height: cardHeight + screenHeight * 0.35,

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/loading_card.json',
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.2,
                    repeat: true,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Cargando noticia...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: descriptionFontSize,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Container(
            width: cardWidth,
            height: cardHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(80),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.image_not_supported,
              size: 60,
              color: Colors.grey,
            ),
          );
        }

        return Card(
          elevation: 10,
          margin: EdgeInsets.only(bottom: spacing * 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          color: Colors.white,
          child: InkWell(
            onTap: () {
              if (noticia.linkMasInfo != null &&
                  noticia.linkMasInfo!.trim().isNotEmpty) {
                OpenLink.abrirEnlace(noticia.linkMasInfo!.trim());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: snapshot.data!,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (noticia.fecha.trim().isNotEmpty)
                        Text(
                          noticia.fecha.toUpperCase(),
                          style: TextStyle(
                            fontSize: dateFontSize,
                            color: const Color(0xFFECBC00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      SizedBox(height: spacing * 0.4),
                      Text(
                        noticia.titulo,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize,
                        ),
                      ),
                      SizedBox(height: spacing),
                      Text(
                        noticia.descripcion.length > 300
                            ? '${noticia.descripcion.substring(0, 300)}...'
                            : noticia.descripcion,
                        style: TextStyle(
                          fontSize: descriptionFontSize,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: spacing),
                      Text(
                        'Leer más',
                        style: TextStyle(
                          fontSize: leerMasFontSize,
                          color: Color(0xFF1A2D93),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget bloqueAyuda({
    IconData? icono,
    required String titulo,
    required String descripcion,
    List<String>? puntos,
  }) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        final iconSize = screenWidth * 0.07;
        final titleFontSize = screenWidth * 0.05;
        final bodyFontSize = screenWidth * 0.045;
        final spacing = screenHeight * 0.015;

        return Container(
          margin: EdgeInsets.symmetric(vertical: spacing),
          padding: EdgeInsets.all(screenWidth * 0.04),
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
                  if (icono != null)
                    Icon(icono, size: iconSize, color: AppColors.appbar),
                  SizedBox(width: icono != null ? screenWidth * 0.025 : 0),
                  Expanded(
                    child: Text(
                      titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing),
              Text(
                descripcion,
                style: TextStyle(fontSize: bodyFontSize),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: spacing * 0.8),
              ...(puntos ?? []).map(
                (p) => Padding(
                  padding: EdgeInsets.only(bottom: spacing * 0.5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: bodyFontSize)),
                      Expanded(
                        child: Text(
                          p,
                          style: TextStyle(fontSize: bodyFontSize),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget pieDePagina(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalMargin = screenWidth * 0.05;
    final iconSize = screenWidth * 0.05;
    final fontSize = screenWidth * 0.04;
    final spacing = screenHeight * 0.015;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing * 1.5),
      child: Column(
        children: [
          Divider(
            indent: horizontalMargin,
            endIndent: horizontalMargin,
            thickness: 1,
            color: AppColors.dividerColor,
          ),

          SizedBox(height: spacing),

          Column(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  OpenLink.abrirEnlace(
                    'https://www.grupotalia.org/privacidad/',
                  );
                },
                icon: Icon(Icons.privacy_tip, size: iconSize),
                label: Text(
                  'Política de Privacidad',
                  style: TextStyle(fontSize: fontSize),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  backgroundColor: AppColors.texto,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: spacing),
              ElevatedButton.icon(
                onPressed: () {
                  OpenLink.abrirEnlace(
                    'https://www.grupotalia.org/avisolegal/',
                  );
                },
                icon: Icon(Icons.gavel, size: iconSize),
                label: Text(
                  'Aviso Legal',
                  style: TextStyle(fontSize: fontSize),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  backgroundColor: AppColors.texto,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spacing * 1.5),

          Column(
            children: [
              Text(
                '© ${DateTime.now().year} Grupo Talía',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize * 0.9,
                  color: Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: spacing),
              Text(
                'Todos los derechos reservados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize * 0.9,
                  color: Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
    double size = 24,
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
