// Librerias Importadas
import 'package:flutter/material.dart';
import 'package:talia_app/helpScreens/help_events.dart';

import '../customColors/app_colors.dart';
import '../widgets/widgets_util.dart';

// Pantalla de selección entre "Anteriores Eventos" y "Próximos Eventos"
class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    // Dimensiones responsivas basadas en el tamaño de pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.08;
    final fontSize = screenWidth * 0.048;

    // Mapeo de items
    final items = [
      {
        'label': 'Anteriores\nEventos',
        'icon': 'assets/icons/pastEventsIcon.png',
        'route': '/screens/previousEvents',
        // Ruta a la pantalla correspondiente
      },
      {
        'label': 'Próximos\nEventos',
        'icon': 'assets/icons/futureEventsIcon.png',
        'route': '/screens/nextEvents',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),

        // Botón de ayuda que redirige a la pantalla HelpEvents
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              try {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpEvents()),
                );
              } catch (e) {
                debugPrint('Error al navegar a HelpEvents: $e');
              }
            },
          ),
        ],
      ),

      // Contenido principal de la pantalla
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          // Límite útil en tablets
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 20,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                // Tamaño máximo por celda
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final item = items[index];

                // Mapeo de items
                return Column(
                  children: [
                    // Imagen interactiva con navegación
                    WidgetsUtil.gridMenu(
                      imagePath: item['icon']!,
                      onTap: () {
                        try {
                          Navigator.pushNamed(context, item['route']!);
                        } catch (e) {
                          debugPrint('Error al navegar: $e');
                        }
                      },
                    ),

                    // Espaciado y etiqueta debajo de cada icono
                    SizedBox(height: screenHeight * 0.01),

                    Text(
                      item['label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.texto,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
