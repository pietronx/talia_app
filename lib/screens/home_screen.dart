// Librerias importadas
import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../widgets/banner.dart';
import '../widgets/widgets_util.dart';

// Pantalla principal de la app que muestra las secciones disponibles
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    // Dimensiones responsivas para paddings y fuente
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.09;
    final verticalPadding = screenHeight * 0.05;

    // Lista de elementos que se mostrarán en el grid
    // Cada elemento incluye: texto, icono y ruta o comando
    final items = [
      ['Sobre Nosotros', 'assets/icons/infoIconBW.png', '/about_us'],
      ['Contacto', 'assets/icons/contactIconBW.png', '/contact'],
      ['Abonados', 'assets/icons/suscriberIcon.png', '/screens/abonados'],
      ['Integrantes del Grupo Talía', 'assets/icons/musicianIconBW.png', '/screens/musicos_screen'],
      ['Eventos', 'assets/icons/eventsIconBW.png', '/screens/events'],
      ['Noticias', 'assets/icons/newsIconBW.png', '/screens/news'],
      ['Refrescar\nla app', 'assets/icons/refreshIconBW.png', 'REFRESCAR'],
      ['Ayuda', 'assets/icons/helpIconBW.png', '/helpScreens/help_screen'],
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Banner superior con imagen y título
          BannerPersonalizado(
            titulo: 'Grupo Talía',
            fontSize: screenWidth * 0.06,
            assetImage: 'assets/images/bannerPrincipal.jpg',
          ),

          // Contenido en forma de grid
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = items[index];
                return _gridItem(context, item[0], item[1], item[2]);
              }, childCount: items.length),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                // Máximo ancho por celda
                mainAxisSpacing: 20,
                crossAxisSpacing: 30,
                childAspectRatio: 0.68, // Relación ancho/alto de cada item
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget individual de cada celda del grid
  Widget _gridItem(
    BuildContext context,
    String label,
    String iconPath,
    String route,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Imagen con funcionalidad de navegación
        WidgetsUtil.gridMenu(
          imagePath: iconPath,
          onTap: () {
            try {
              if (route == 'REFRESCAR') {
                // Si se pulsa "Refrescar", recarga la pantalla y muestra SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Refrescando contenido...'),
                    duration: Duration(seconds: 2),
                  ),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const HomeScreen(titulo: "Grupo Talía"),
                  ),
                );
              } else {
                // Si es una ruta normal, navega a ella
                Navigator.pushNamed(context, route);
              }
            } catch (e) {
              debugPrint('Error al navegar: $e');
            }
          },
        ),

        SizedBox(height: screenHeight * 0.01),

        // Nombre debajo del icono
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
            color: AppColors.texto,
          ),
        ),
      ],
    );
  }
}
