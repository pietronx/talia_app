// Librerias importadas
import 'package:flutter/material.dart';
import 'package:talia_app/customColors/app_colors.dart';
import 'package:talia_app/helpScreens/help_about_us.dart';
import 'package:talia_app/helpScreens/help_contact.dart';
import 'package:talia_app/helpScreens/help_legal.dart';

import '../credits/credits_screen.dart';

// Clase para la pantalla de ayuda sin conexión
class HelpOffline extends StatelessWidget {
  const HelpOffline({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.06;
    final titleFontSize = screenWidth * 0.06;
    final bodyFontSize = screenWidth * 0.045;
    final spacingLarge = screenHeight * 0.03;
    final spacingSmall = screenHeight * 0.015;
    final iconSize = screenWidth * 0.06;

    // Mapeo de secciones
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
        padding: EdgeInsets.all(horizontalPadding),
        child: ListView(
          children: [
            Text(
              'Guía de Ayuda sin conexión',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacingSmall),
            Text(
              'Estás en modo sin conexión. Aquí puedes acceder a algunas secciones informativas de la aplicación.',
              style: TextStyle(fontSize: bodyFontSize),
            ),
            SizedBox(height: spacingLarge),

            // Mapeo de secciones
            ...secciones.map((seccion) {
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: spacingSmall,
                  horizontal: spacingSmall * 0.7,
                ),
                color: AppColors.fondo,
                elevation: 3,
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
                      color: AppColors.texto,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: iconSize),
                  onTap: () {
                    try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => seccion['pantalla'] as Widget,
                        ),
                      );
                    } catch (e) {
                      debugPrint('Error al navegar a ${seccion['titulo']}: $e');
                    }
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
