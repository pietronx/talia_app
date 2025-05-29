// Librerias importadas
import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/about_us.dart';
import '../widgets/widgets_util.dart';

// Clase para mostrar la ayuda de sobre nosotros
class HelpAboutUs extends StatelessWidget {
  const HelpAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.06;
    final spacing = screenHeight * 0.03;

    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Sobre Nosotros')),
      body: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: ListView(
          children: [
            Text(
              '¿Que puedes hacer aquí?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spacing),

            // Secciones de ayuda
            WidgetsUtil.bloqueAyuda(
              icono: Icons.image,
              titulo: 'Imagen del Grupo Talía',
              descripcion:
                  'Al inicio encontrarás un banner visual con la imagen del grupo y varios enlaces.\n'
                  'Toca los iconos para acceder a ellos',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.people,
              titulo: 'Directores',
              descripcion:
                  'Verás fotos de los directores del grupo y una breve descripción.',
              puntos: [
                'Cada director tiene iconos debajo con enlaces a sus redes sociales.',
                'Toca los iconos para abrir sus perfiles en Facebook, Instagram, Twitter o LinkedIn.',
              ],
            ),

            WidgetsUtil.bloqueAyuda(
              titulo: 'Pie de página',
              descripcion:
                  'Al final de la pantalla encontrarás enlaces importantes:',
              puntos: ['Política de Privacidad', 'Aviso Legal'],
            ),

            SizedBox(height: spacing),

            // Botón para ir a "Sobre Nosotros"
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.feed),
                label: const Text('Ir a "Sobre Nosotros"'),
                onPressed: () {
                  try {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutUs()),
                    );
                  } catch (e) {
                    debugPrint('Error al navegar a AboutUs: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.texto,
                  foregroundColor: Colors.white,
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
