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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final maxContentWidth = 600.0;

    final horizontalPadding = screenWidth * 0.07;
    final verticalPadding = screenHeight * 0.05;
    final titleFontSize = screenWidth * 0.06;
    final bodyFontSize = screenWidth * 0.045;
    final sectionSpacing = screenHeight * 0.03;
    final iconSize = screenWidth * 0.06;

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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: ListView(
              children: [
                Text(
                  'Guía de Ayuda',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.texto,
                  ),
                ),
                SizedBox(height: sectionSpacing * 0.6),

                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: AppColors.texto,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Selecciona una sección para recibir ayuda sobre cómo usar esa parte de la aplicación.\n\n'
                            'Encontrarás explicaciones sencillas y enlaces útiles para navegar sin dificultad.\n\n'
                            'En la ',
                      ),
                      TextSpan(
                        text: 'pantalla de inicio',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: ', encontrarás cinco iconos que te ayudarán a navegar por la aplicación.\n\n'
                            'El primer icono, ',
                      ),
                      TextSpan(
                        text: '"Refrescar"',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: ' , sirve para actualizar el contenido de la app como eventos, noticias, etc.',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: sectionSpacing),

                ...secciones.map((seccion) {
                  return Card(
                    margin: EdgeInsets.symmetric(
                      vertical: sectionSpacing * 0.3,
                      horizontal: sectionSpacing * 0.3,
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
                          fontSize: bodyFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppColors.texto,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: iconSize),
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
        ),
      ),
    );
  }
}
