// Librerias importadas
import 'package:flutter/material.dart';
import '../customColors/app_colors.dart';
import '../screens/contact.dart';
import '../widgets/widgets_util.dart';

// Clase para mostrar la ayuda de contacto
class HelpContact extends StatelessWidget {
  const HelpContact({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.06;
    final spacingLarge = screenHeight * 0.025;
    final spacingSmall = screenHeight * 0.015;

    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Contacto')),
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

            // Bloques de ayuda
            WidgetsUtil.bloqueAyuda(
              icono: Icons.location_on,
              titulo: 'Dirección',
              descripcion:
              'Puedes ver la ubicación de la oficina del Grupo Talía tocando la dirección mostrada',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.phone,
              titulo: 'Teléfono de contacto',
              descripcion:
              'Puedes llamar directamente tocando el número mostrado.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.email,
              titulo: 'Correo electrónico',
              descripcion:
              'Si deseas enviar un email, solo tienes que tocar la dirección y se abrirá tu app de correo.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.access_time,
              titulo: 'Horario de atención',
              descripcion:
              'El horario indica cuándo puedes contactar o acudir a la sede.',
            ),

            WidgetsUtil.bloqueAyuda(
              titulo: 'Pie de página',
              descripcion:
              'Al final de la pantalla encontrarás enlaces importantes:',
              puntos: [
                'Política de Privacidad',
                'Aviso Legal',
              ],
            ),

            SizedBox(height: spacingSmall),

            // Botón para ir a "Contacto"
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Contact()),
                  );
                  } catch (e) {
                    debugPrint('Error al navegar a Contact: $e');
                  }
                },
                icon: const Icon(Icons.people),
                label: const Text('Ir a "Contacto"'),
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