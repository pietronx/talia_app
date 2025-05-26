// Librerias importadas
import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../widgets/widgets_util.dart';

// Clase para la pantalla de ayuda de legal y privacidad
class HelpLegal extends StatelessWidget {
  const HelpLegal({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.07;
    final titleFontSize = screenWidth * 0.06;
    final paragraphFontSize = screenWidth * 0.045;
    final spacingLarge = screenHeight * 0.03;
    final spacingSmall = screenHeight * 0.015;

    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Legal y Privacidad')),
      body: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Política de Privacidad\nAviso Legal',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacingLarge),
            Text(
              'En esta sección puedes acceder a nuestra Política de Privacidad y al Aviso Legal del Grupo Talía.',
              style: TextStyle(fontSize: paragraphFontSize),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacingSmall),
            Text(
              'Ambos documentos explican cómo protegemos tus datos personales y cuáles son tus derechos como usuario.',
              style: TextStyle(fontSize: paragraphFontSize),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacingLarge),

            // Boton para abrir el enlace de la politica de privacidad
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  OpenLink.abrirEnlace(
                    'https://www.grupotalia.org/privacidad/',
                  );
                },
                icon: const Icon(Icons.privacy_tip),
                label: const Text('Ver Política de Privacidad'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.texto,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: spacingSmall,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            SizedBox(height: spacingSmall),

            // Boton para abrir el enlace del aviso legal
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  OpenLink.abrirEnlace(
                    'https://www.grupotalia.org/avisolegal/',
                  );
                },
                icon: const Icon(Icons.gavel),
                label: const Text('Ver Aviso Legal'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.texto,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: spacingSmall,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
