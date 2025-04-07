import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../widgets/widgets_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: AppColors.fondo
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Banner
                WidgetsUtil.contenedorPersonalizado(
                  width: 300,
                  height: 130,
                  path: 'assets/images/bannerGrupoTalia.png',
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 40),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Muestra dos columnas
                  crossAxisCount: 2,

                  // Espacio horizontal entre columnas
                  crossAxisSpacing: 10,

                  // Espacio vertical entre filas
                  mainAxisSpacing: 10,

                  // Relación ancho/alto de cada celda: 0.7 = más alta que ancha
                  childAspectRatio: 0.7,
                  children: [
                    // SOBRE NOSOTROS
                    Column(
                      children: [
                        WidgetsUtil.gridMenu(
                          imagePath: 'assets/icons/aboutUsIcon.png',
                          onTap:
                              () => Navigator.pushNamed(context, '/about_us'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Sobre Nosotros',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.texto,
                          ),
                        ),
                      ],
                    ),
                    // CONTACTO
                    Column(
                      children: [
                        WidgetsUtil.gridMenu(
                          imagePath: 'assets/icons/contactIcon.png',
                          onTap: () => Navigator.pushNamed(context, '/contact'),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Contacto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.texto,
                          ),
                        ),
                      ],
                    ),
                    // CALENDARIO
                    Column(
                      children: [
                        WidgetsUtil.gridMenu(
                          imagePath: 'assets/icons/eventIcon.png',
                          onTap:
                              () => Navigator.pushNamed(context, '/calendar'),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Eventos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.texto,
                          ),
                        ),
                      ],
                    ), // AYUDA
                    Column(
                      children: [
                        WidgetsUtil.gridMenu(
                          imagePath: 'assets/icons/supportIcon.png',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/helpScreens/help_screen',
                              ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Ayuda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.texto,
                          ),
                        ),
                      ],
                    ),

                    //AYUDA
                    Column(
                      children: [
                        WidgetsUtil.gridMenu(
                          imagePath: 'assets/icons/supportIcon.png',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/helpScreens/help_screen',
                              ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Ayuda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.texto,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        WidgetsUtil.gridMenu(
                          imagePath: 'assets/icons/supportIcon.png',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/helpScreens/help_screen',
                              ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Ayuda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.texto,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
