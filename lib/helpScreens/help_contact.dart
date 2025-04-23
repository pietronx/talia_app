import 'package:flutter/material.dart';
import '../customColors/app_colors.dart';
import '../screens/contact.dart';
import '../widgets/widgets_util.dart';

class HelpContact extends StatelessWidget {
  const HelpContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Contacto')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              '¿Qué encontrarás en "Contacto"?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

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

            const SizedBox(height: 10),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Contact()),
                  );
                },
                icon: const Icon(Icons.people),
                label: const Text('Ir a "Contacto"'),
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
