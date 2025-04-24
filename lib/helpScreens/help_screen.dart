import 'package:flutter/material.dart';
import 'package:talia_app/credits/credits_screen.dart';
import 'package:talia_app/helpScreens/help_contact.dart';
import 'package:talia_app/helpScreens/help_legal.dart';
import 'package:talia_app/helpScreens/help_next_events.dart';

import '../customColors/app_colors.dart';
import '../screens/home_screen.dart';
import 'help_about_us.dart';
import 'help_events.dart';
import 'help_previous_events.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final secciones = [
      {'titulo': 'Inicio', 'pantalla': const HomeScreen(titulo: 'Inicio')},
      {'titulo': 'Sobre Nosotros', 'pantalla': const HelpAboutUs()},
      {'titulo': 'Contacto', 'pantalla': const HelpContact()},
      {'titulo': 'Eventos', 'pantalla': const HelpEvents()},
      {'titulo': 'Anteriores Eventos', 'pantalla': const HelpPreviousEvents()},
      {'titulo': 'Próximos Eventos', 'pantalla': const HelpNextEvents()},
      {'titulo': 'Políticas de Privacidad', 'pantalla': const HelpLegal()},
      {'titulo': 'Créditos', 'pantalla': const CreditsScreen()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Guía de Ayuda',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Selecciona una sección para recibir ayuda sobre cómo usar esa parte de la aplicación.\n\n'
              'Encontrarás exlicaciones sencillas y enlaces útiles para navegar sin dificultad.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Lista de secciones
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
