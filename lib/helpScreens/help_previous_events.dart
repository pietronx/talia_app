// Librerias importadas
import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/previous_events.dart';
import '../widgets/widgets_util.dart';

// Clase para la pantalla de ayuda de eventos anteriores
class HelpPreviousEvents extends StatelessWidget {
  const HelpPreviousEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.06;
    final titleFontSize = screenWidth * 0.06;
    final spacingLarge = screenHeight * 0.03;
    final spacingSmall = screenHeight * 0.015;

    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Anteriores Eventos')),
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

            WidgetsUtil.bloqueAyuda(
              icono: Icons.event_available,
              titulo: 'Eventos para recordar',
              descripcion:
                  'Aquí encontrarás eventos ya celebrados por Grupo Talía.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.touch_app,
              titulo: 'Interacción con las tarjetas',
              descripcion:
                  'Puedes tocar sobre cada tarjeta '
                  'para abrir una ventana con información detallada del evento.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.image,
              titulo: 'Eventos',
              descripcion:
                  'Cada evento tiene una imagen representativa y una descripción.\n\n'
                  'Debajo de esta, si está disponible, podrás ver un para botón que al tocarlo, '
                  'te abrirá un PDF con el programa de mano del evento.',
            ),

            SizedBox(height: spacingLarge),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PreviousEvents()),
                    );
                  } catch (e) {
                    debugPrint('Error al navegar a PreviousEvents: $e');
                  }
                },
                icon: const Icon(Icons.event),
                label: const Text('Ir a "Anteriores Eventos"'),
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
