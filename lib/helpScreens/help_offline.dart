import 'package:flutter/material.dart';
import 'package:talia_app/customColors/app_colors.dart';
import 'package:talia_app/helpScreens/help_about_us.dart';
import 'package:talia_app/helpScreens/help_contact.dart';
import 'package:talia_app/helpScreens/help_legal.dart';

import '../credits/credits_screen.dart';

class HelpOffline extends StatelessWidget {
  const HelpOffline({super.key});

  @override
  Widget build(BuildContext context) {
    final secciones = [
      {'titulo': 'Sobre Nosotros', 'pantalla': const HelpAboutUs()},
      {'titulo': 'Contacto', 'pantalla': const HelpContact()},
      {'titulo': 'Créditos', 'pantalla': const CreditsScreen()},
      {'titulo': 'Política de Privacidad', 'pantalla': const HelpLegal()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda sin conexión'),
        backgroundColor: AppColors.appbar,
      ),
      backgroundColor: AppColors.fondo,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Guía de Ayuda sin conexión',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Estás en modo sin conexión. Aquí puedes acceder a algunas secciones informativas de la aplicación.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            ...secciones.map((seccion) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                color: AppColors.fondo,
                elevation: 3,
                shadowColor: AppColors.titulo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    seccion['titulo'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => seccion['pantalla'] as Widget,
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}