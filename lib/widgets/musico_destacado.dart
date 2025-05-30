import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../customColors/app_colors.dart';
import '../helpers/link_helper.dart';

class MusicoDestacado extends StatelessWidget {
  final String nombre;
  final String instrumento;
  final String descripcion;
  final String fotoUrl;

  const MusicoDestacado({
    super.key,
    required this.nombre,
    required this.instrumento,
    required this.descripcion,
    required this.fotoUrl,
  });

  Future<Image> _cargarImagen(BuildContext context, String url) async {
    final image = Image.network(url, fit: BoxFit.contain);
    await precacheImage(image.image, context);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final baseFontSize = screenWidth * 0.045;
    final cardMarginHorizontal = screenWidth * 0.06;
    final cardMarginVertical = screenHeight * 0.02;
    final cardPaddingHorizontal = screenWidth * 0.05;
    final cardPaddingVertical = screenHeight * 0.03;
    final cardWidth = screenWidth - (2 * cardMarginHorizontal);
    final imageHeight = cardWidth;
    final topImageGap = screenHeight * 0.02; // Espacio en el top de la imagen

    return FutureBuilder<Image>(
      future: _cargarImagen(context, LinkHelper.vistaPreviaDrive(fotoUrl)),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            padding: EdgeInsets.all(cardPaddingHorizontal),
            margin: EdgeInsets.symmetric(
              vertical: cardMarginVertical,
              horizontal: cardMarginHorizontal,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(cardPaddingHorizontal),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/loading_card.json',
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  repeat: true,
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Cargando músico...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: baseFontSize),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Container(
            padding: EdgeInsets.all(cardPaddingHorizontal),
            margin: EdgeInsets.symmetric(
              vertical: cardMarginVertical,
              horizontal: cardMarginHorizontal,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(cardPaddingHorizontal),
            ),
            child: Center(
              child: Text(
                'Error al cargar el músico',
                style: TextStyle(fontSize: baseFontSize, color: Colors.red),
              ),
            ),
          );
        }

        final loadedImage = snapshot.data!;

        return Card(
          elevation: 4,
          color: AppColors.fondo,
          margin: EdgeInsets.symmetric(
            vertical: cardMarginVertical,
            horizontal: cardMarginHorizontal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: imageHeight,
                  child: Padding(
                    padding: EdgeInsets.only(top: topImageGap),
                    child: loadedImage,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: cardPaddingHorizontal,
                  vertical: cardPaddingVertical,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: TextStyle(
                        fontSize: baseFontSize * 1.3,
                        fontWeight: FontWeight.bold,
                        color: AppColors.titulo,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      instrumento,
                      style: TextStyle(
                        fontSize: baseFontSize,
                        fontStyle: FontStyle.italic,
                        color: AppColors.appbarIcons,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      descripcion,
                      style: TextStyle(
                        fontSize: baseFontSize * 0.9,
                        color: AppColors.texto,
                      ),
                      textAlign: TextAlign.justify,
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
}