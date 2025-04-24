import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/about_us.dart';
import '../widgets/widgets_util.dart';

class HelpAboutUs extends StatelessWidget {
  const HelpAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Sobre Nosotros')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              '¿Que puedes hacer aquí?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.image,
              titulo: 'Imagen del Grupo Talía',
              descripcion:
                  'Al inicio encontrarás un banner visual con la imagen del grupo y varios enlaces.\n'
                  'Toca los iconos para acceder a ellos',
            ),

            WidgetsUtil.bloqueAyuda(
              icono: Icons.people,
              titulo: 'Directores',
              descripcion:
                  'Verás fotos de los directores del grupo y una breve descripción.',
              puntos: [
                'Cada director tiene iconos debajo con enlaces a sus redes sociales.',
                'Toca los iconos para abrir sus perfiles en Facebook, Instagram, Twitter o LinkedIn.',
              ],
            ),

            WidgetsUtil.bloqueAyuda(
              titulo: 'Pie de página',
              descripcion:
                  'Al final de la pantalla encontrarás enlaces importantes:',
              puntos: ['Política de Privacidad', 'Aviso Legal'],
            ),

            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutUs()),
                  );
                },
                icon: const Icon(Icons.feed),
                label: const Text('Ir a "Sobre Nosotros"'),
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
