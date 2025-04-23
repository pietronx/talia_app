import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/next_events.dart';
import '../widgets/widgets_util.dart';

class HelpNextEvents extends StatelessWidget {
  const HelpNextEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Próximos Eventos')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              '¿Qué puedes hacer en aquí?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.calendar_today,
              titulo: 'Calendario interactivo',
              descripcion: 'Aquí puedes consultar los próximos conciertos y actividades programadas.',
              puntos: [
                'Los días con eventos se marcan con un círculo especial.',
                'Toca cualquier día del calendario para ver si hay un concierto planificado.',
              ],
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.info_outline,
              titulo: 'Detalles del evento',
              descripcion: 'Al seleccionar un día con evento, verás la información relevante:',
              puntos: [
                'Nombre del concierto',
                'Hora y lugar',
                'Notas adicionales si las hay',
              ],
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.favorite,
              titulo: 'Eventos favoritos',
              descripcion: 'Puedes marcar tus eventos preferidos tocando el icono del corazón.',
              puntos: [
                'Accede a la lista completa desde el botón "Favoritos".',
                'Puedes quitar o añadir conciertos en cualquier momento.',
              ],
            ),

            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NextEvents()),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text('Ir a "Próximos Eventos"'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.texto,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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