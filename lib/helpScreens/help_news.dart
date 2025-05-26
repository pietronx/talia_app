// Librerias importadas
import 'package:flutter/material.dart';
import '../customColors/app_colors.dart';
import '../screens/news.dart';
import '../widgets/widgets_util.dart';

// Clase para la pantalla de ayuda de noticias
class HelpNews extends StatelessWidget {
  const HelpNews({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.06;
    final spacingLarge = screenHeight * 0.03;
    final spacingSmall = screenHeight * 0.015;

    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Noticias')),
      body: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: ListView(
          children: [
            Text(
              '¿Qué puedes hacer aquí?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: spacingLarge),

            // Secciones de ayuda
            WidgetsUtil.bloqueAyuda(
              icono: Icons.newspaper,
              titulo: 'El día a día',
              descripcion:
              'Aquí encontrarás las noticias más recientes de Grupo Talía.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.image,
              titulo: 'Noticias',
              descripcion:
              'Cada noticia tiene una imagen representativa y una descripción.\n\n'
                  'Si tocas sobre cada tarjeta irás a la web oficial, '
                  'donde podrás encontrar más informacion sobre la noticia.',
            ),

            SizedBox(height: spacingSmall),

            // Botón para ir a la pantalla de noticias
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const News()),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text('Ir a "Noticias"'),
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