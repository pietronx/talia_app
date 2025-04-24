import 'package:flutter/material.dart';
import 'package:talia_app/screens/events.dart';

import '../customColors/app_colors.dart';
import '../widgets/widgets_util.dart';

class HelpEvents extends StatelessWidget {
  const HelpEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Próximos Eventos')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              '¿Qué puedes hacer aquí?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.calendar_today,
              titulo: 'Anteriores Eventos',
              descripcion: 'Si tocas el icono, puedes consultar los conciertos y eventos para recordar.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.calendar_today,
              titulo: 'Próximos Eventos',
              descripcion: 'Si tocas el icono, puedes consultar los próximos conciertos y actividades programadas.',
            ),

            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Events()),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text('Ir a "Eventos"'),
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