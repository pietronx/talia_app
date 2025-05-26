// Librerias importadas
import 'package:flutter/material.dart';
import '../customColors/app_colors.dart';
import 'animation_credits.dart';
import 'icon_credits.dart';

// Clase de Creditos
class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final padding = screenWidth * 0.07;
    final titleFontSize = screenWidth * 0.07;
    final bodyFontSize = screenWidth * 0.04;
    final spacing = screenHeight * 0.02;

    // Secciones de creditos
    final secciones = [
      {'titulo': 'Iconos', 'pantalla': const IconCredits()},
      {'titulo': 'Animaciones', 'pantalla': const AnimationCredits()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créditos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: ListView(
          children: [
            Text(
              'Información',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacing * 0.6),
            Text(
              'Encontrarás enlaces y autores acreditados para cada uno de los recursos utilizados en la aplicación.',
              style: TextStyle(fontSize: bodyFontSize),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: spacing * 1),

            // Mapeo de secciones
            ...secciones.map((seccion) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: spacing * 0.6, horizontal: spacing * 0.3),
                color: AppColors.fondo,
                elevation: 5,
                shadowColor: AppColors.titulo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    seccion['titulo'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: bodyFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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