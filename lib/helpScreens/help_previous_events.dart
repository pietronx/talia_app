import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/previous_events.dart';
import '../widgets/widgets_util.dart';

class HelpPreviousEvents extends StatelessWidget {
  const HelpPreviousEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Anteriores Eventos')),
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

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PreviousEvents()),
                  );
                },
                icon: const Icon(Icons.event),
                label: const Text('Ir a "Anteriores Eventos"'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.texto,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
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
