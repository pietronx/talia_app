import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/musicos_screen.dart';
import '../widgets/widgets_util.dart';

class HelpMusician extends StatelessWidget {
  const HelpMusician({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.06;
    final spacingLarge = screenHeight * 0.03;
    final spacingSmall = screenHeight * 0.015;

    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Integrantes')),
      body: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: ListView(
          children: [
            Text(
              '¿Qué puedes hacer aquí?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spacingLarge),

            // Secciones de ayuda
            WidgetsUtil.bloqueAyuda(
              icono: Icons.people,
              titulo: 'Descubre a nuestro equipo',
              descripcion:
                  'Aquí puedes conocer a los talentosos integrantes del equipo '
                  'que forman parte del Grupo Talía.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.music_note,
              titulo: 'Información de cada uno',
              descripcion:
                  'Cada integrante cuenta con una ficha que muestra su foto y una descripción sobre ellos',
            ),

            SizedBox(height: spacingSmall),

            // Botón para ir a la pantalla de músicos
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Musicos()),
                    );
                  } catch (e) {
                    debugPrint('Error al navegar a Musicos: $e');
                  }
                },
                icon: const Icon(Icons.library_music),
                label: const Text('Ir a "Integrantes"'),
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
