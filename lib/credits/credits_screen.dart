import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/home_screen.dart';
import 'icon_credits.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final secciones = [
      {'titulo': 'Inicio', 'pantalla': const HomeScreen(titulo: 'Inicio',)},
      {'titulo': 'Iconos', 'pantalla': const IconCredits()},
      {'titulo': 'Koobin', 'pantalla': const CreditsScreen()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créditos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Información',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Encontrarás enlaces y autores acreditados para cada uno de los recursos utilizados en la aplicación.',
              style: TextStyle(fontSize: 15),
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
            })
          ],
        ),
      ),
    );
  }
}