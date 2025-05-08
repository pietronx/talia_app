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
              '¿Qué puedes hacer aquí?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

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
                  'te dirigirá a la página webs donde podrás comprar las entradas del evento'
            ),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NextEvents()),
                  );
                },
                icon: const Icon(Icons.event),
                label: const Text('Ir a "Próximos Eventos"'),
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