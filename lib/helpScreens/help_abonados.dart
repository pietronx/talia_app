import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/abonados.dart';
import '../widgets/widgets_util.dart';

class HelpAbonados extends StatelessWidget {
  const HelpAbonados({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.06;
    final spacingLarge = screenHeight * 0.03;
    final spacingSmall = screenHeight * 0.015;

    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Abonados')),
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
              icono: Icons.card_membership,
              titulo: 'Comprar un abono',
              descripcion:
              'Aquí puedes adquirir tu abono para la temporada de conciertos '
                  'y disfrutar de múltiples ventajas.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.update,
              titulo: 'Renovar tu abono',
              descripcion:
              'Si ya eres abonado, puedes renovar tu abono, '
              'iniciando sesión en Koobin y seleccionando "renovar abono" para '
                  'seguir disfrutando de todas sus ventajas.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.star,
              titulo: 'Ver las Ventajas exclusivas',
              descripcion:
              'Los abonados disfrutan de descuentos, venta preferente, atención personalizada '
                  'y acceso a eventos especiales.',
            ),

            SizedBox(height: spacingSmall),

            // Botón para ir a la pantalla de abonados
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Abonados()),
                    );
                  } catch (e) {
                    debugPrint('Error al navegar a Abonados: $e');
                  }
                },
                icon: const Icon(Icons.call_to_action_outlined),
                label: const Text('Ir a "Abonados"'),
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