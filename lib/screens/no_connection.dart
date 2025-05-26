// Librerias importadas
import 'package:flutter/material.dart';
import 'package:talia_app/customColors/app_colors.dart';

import '../widgets/widgets_util.dart';
import 'splash_screen.dart';

// Pantalla que se muestra cuando no hay conexión a Internet
class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

  @override
  Widget build(BuildContext context) {
    // Dimensiones responsivas
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    // Opciones disponibles en modo offline
    final items = [
      ['Sobre Nosotros', 'assets/icons/infoIcon.png', '/about_us'],
      ['Contacto', 'assets/icons/contactIcon.png', '/contact'],
      ['Ayuda', 'assets/icons/helpIcon.png', '/helpScreens/help_offline'],
    ];

    return Scaffold(
      backgroundColor: AppColors.fondo,
      appBar: AppBar(
        title: const Text('Modo Sin Conexión'),
        backgroundColor: AppColors.appbar,
      ),
      body: CustomScrollView(
        slivers: [
          // Sección de advertencia y botón de reintento
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.04,
                horizontal: screenWidth * 0.08,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.wifi_off,
                    size: screenWidth * 0.2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    "No se ha detectado conexión a Internet.\n"
                    "Para utilizar más funciones de la app,\n"
                    "conéctese a Internet y vuelva a intentarlo.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenWidth * 0.045),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Botón para recargar el SplashScreen y forzar nuevo intento de conexión
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SplashScreen()),
                      );
                    },
                    icon: Icon(Icons.refresh, size: screenWidth * 0.05),
                    label: Text(
                      'Reintentar',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                      ),
                      backgroundColor: AppColors.texto,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
          ),

          // Grid de las dos primeras opciones
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.09,
              vertical: screenHeight * 0.01,
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index >= 2) {
                  return const SizedBox();
                } // Solo muestra los 2 primeros
                final item = items[index];
                return _gridItem(
                  context,
                  item[0],
                  item[1],
                  item[2],
                  screenHeight,
                  screenWidth,
                );
              }, childCount: 2),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: isTablet ? 300 : 220,
                mainAxisSpacing: screenHeight * 0.03,
                crossAxisSpacing: screenWidth * 0.04,
                childAspectRatio: 0.7,
              ),
            ),
          ),

          // Último ítem (Ayuda) centrado de forma independiente
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.01,
                bottom: screenHeight * 0.05,
              ),
              child: Center(
                child: _gridItem(
                  context,
                  items[2][0],
                  items[2][1],
                  items[2][2],
                  screenHeight,
                  screenWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget reutilizable para los elementos del grid
  Widget _gridItem(
    BuildContext context,
    String label,
    String iconPath,
    String route,
    double screenHeight,
    double screenWidth,
  ) {
    return Column(
      children: [
        WidgetsUtil.gridMenu(
          imagePath: iconPath,
          onTap: () => Navigator.pushNamed(context, route),
          height: screenHeight * 0.15,
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: AppColors.texto,
          ),
        ),
      ],
    );
  }
}
