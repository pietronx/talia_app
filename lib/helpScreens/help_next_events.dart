// Librerias importadas
import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/next_events.dart';
import '../widgets/widgets_util.dart';

// Clase para la pantalla de ayuda de proximos eventos
class HelpNextEvents extends StatelessWidget {
  const HelpNextEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.06;
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

            WidgetsUtil.bloqueAyuda(
              icono: Icons.event_available,
              titulo: 'Próximos Eventos',
              descripcion:
                  'Aquí encontrarás los próximos eventos que celebrará el Grupo Talía.',
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
                  'Debajo de esta podrás ver un para botón que al tocarlo, '
                  'te dirigirá a la página webs donde podrás comprar las entradas del evento',
            ),

            SizedBox(height: spacingLarge),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NextEvents()),
                    );
                  } catch (e) {
                    debugPrint('Error al navegar a NextEvents: $e');
                  }
                },
                icon: const Icon(Icons.event),
                label: const Text('Ir a "Próximos Eventos"'),
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
