import 'package:flutter/material.dart';
import '../widgets/widgets_util.dart';

class HelpLegal extends StatelessWidget {
  const HelpLegal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Legal y Privacidad')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Política de Privacidad y Aviso Legal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'En esta sección puedes acceder a nuestra Política de Privacidad y al Aviso Legal del Grupo Talía.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ambos documentos explican cómo protegemos tus datos personales y cuáles son tus derechos como usuario.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Botón Política de Privacidad
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  OpenLink.abrirEnlace('https://www.grupotalia.org/privacidad/');
                },
                icon: const Icon(Icons.privacy_tip),
                label: const Text('Ver Política de Privacidad'),
              ),
            ),

            const SizedBox(height: 15),

            // Botón Aviso Legal
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  OpenLink.abrirEnlace('https://www.grupotalia.org/avisolegal/');
                },
                icon: const Icon(Icons.gavel),
                label: const Text('Ver Aviso Legal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
