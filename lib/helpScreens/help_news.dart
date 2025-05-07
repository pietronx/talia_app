import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/news.dart';
import '../widgets/widgets_util.dart';

class HelpNews extends StatelessWidget {
  const HelpNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Noticias')),
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
              icono: Icons.newspaper,
              titulo: 'El día a día',
              descripcion:
                  'Aquí encontrarás las noticias más recientes de Grupo Talía.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.touch_app,
              titulo: 'Interacción con las tarjetas',
              descripcion:
                  'Puedes tocar sobre cada tarjeta '
                  'para abrir una ventana con información detallada de la noticia.',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.image,
              titulo: 'Noticias',
              descripcion:
                  'Cada noticia tiene una imagen representativa y una descripción.\n\n'
                  'Podrás ver la imagen completa, la descripción y, si está disponible, '
                  'un botón para dirigirte '
                  'a la web con más información sobre la misma.',
            ),

            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const News()),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text('Ir a "Noticias"'),
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
