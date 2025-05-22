import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:talia_app/customColors/app_colors.dart';
import '../widgets/widgets_util.dart';

class AnimationCredits extends StatelessWidget {
  const AnimationCredits({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.06;
    final verticalPadding = screenHeight * 0.03;
    final titleFontSize = screenWidth * 0.06;
    final bodyFontSize = screenWidth * 0.042;
    final spacing = screenHeight * 0.015;

    final creditos = [
      {
        'animation': 'assets/animations/loading.json',
        'descripcion': 'Animación de carga creada por Mehran',
        'url': 'https://lottiefiles.com/free-animation/ukulele-loading-fP3ZkohebE',
      },
      {
        'animation': 'assets/animations/loading_card.json',
        'descripcion': 'Animación de carga de eventos creada por Endri K',
        'url': 'https://lottiefiles.com/free-animation/loading-musick-track-ndOSAWvZul',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Créditos de Animaciones')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: ListView(
          children: [
            Text(
              'Sobre las animaciones utilizadas',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.texto,
              ),
            ),
            SizedBox(height: spacing),
            Text(
              'Todas las animaciones que aparecen a continuación han sido utilizadas de acuerdo con los:',
              style: TextStyle(
                fontSize: bodyFontSize,
                color: AppColors.texto,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: spacing * 0.7),
            InkWell(
              onTap: () => OpenLink.abrirEnlace('https://lottiefiles.com/es/page/terms-and-conditions'),
              child: Text(
                '• Términos de uso',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: bodyFontSize,
                ),
              ),
            ),
            SizedBox(height: spacing * 0.4),
            InkWell(
              onTap: () => OpenLink.abrirEnlace('https://lottiefiles.com/page/license'),
              child: Text(
                '• Licencia simple de Lottie',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: bodyFontSize,
                ),
              ),
            ),
            SizedBox(height: spacing * 2),

            // Lista de tarjetas con animaciones
            ...creditos.map(
                  (item) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                shadowColor: AppColors.titulo,
                margin: EdgeInsets.symmetric(vertical: spacing * 1.2, horizontal: spacing * 0.25),
                color: AppColors.fondo,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.1,
                        child: Lottie.asset(
                          item['animation'] as String,
                          repeat: true,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: spacing),
                      Text(
                        item['descripcion'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: bodyFontSize),
                      ),
                      SizedBox(height: spacing * 0.5),
                      GestureDetector(
                        onTap: () => OpenLink.abrirEnlace(item['url'] as String),
                        child: Text(
                          'Ver en LottieFiles',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: bodyFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}