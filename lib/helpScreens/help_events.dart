// Librerias importadas
import 'package:flutter/material.dart';
import 'package:talia_app/screens/events.dart';

import '../customColors/app_colors.dart';
import '../widgets/widgets_util.dart';

// Clase para mostrar la ayuda de eventos
class HelpEvents extends StatelessWidget {
  const HelpEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.06;
    final spacingLarge = screenHeight * 0.03;
    final spacingSmall = screenHeight * 0.015;

    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Próximos Eventos')),
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
              icono: Icons.calendar_today,
              titulo: 'Anteriores Eventos',
              descripcion:
                  'Si tocas el icono, puedes consultar los conciertos y eventos para recordar.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.calendar_today,
              titulo: 'Próximos Eventos',
              descripcion:
                  'Si tocas el icono, puedes consultar los próximos conciertos y actividades programadas.',
            ),

            SizedBox(height: spacingSmall),

            // Botón para ir a "Eventos"
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Events()),
                    );
                  } catch (e) {
                    debugPrint('Error al navegar a Events: $e');
                  }
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text('Ir a "Eventos"'),
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
