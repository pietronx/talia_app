import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_about_us.dart';
import '../widgets/widgets_util.dart';
import 'about_us.dart';

class PreviousEvents extends StatelessWidget {
  const PreviousEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anteriores Eventos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            color: AppColors.appbarIcons,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpAboutUs()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titulo
                WidgetsUtil.contenedorPersonalizado(
                  text: 'Eventos para Recordar',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textoColor: AppColors.titulo,
                ),
                Divider(
                  height: 0.1,
                  indent: 30,
                  endIndent: 30,
                  thickness: 2,
                  color: AppColors.drawerCabecera,
                ),

                const SizedBox(height: 30),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Muestra dos columnas
                  crossAxisCount: 1,

                  // Espacio horizontal entre columnas
                  crossAxisSpacing: 20,

                  // Espacio vertical entre filas
                  mainAxisSpacing: 10,

                  // Relación ancho/alto de cada celda: 0.7 = más alta que ancha
                  childAspectRatio: 0.8,

                  children: [
                    // En clave 2
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AboutUs(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: Image.network(
                              'https://drive.google.com/uc?export=view&id=1PMV_xLNE73Ax3qm0UsbGz2wWe0CsSFq2',
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text('No se pudo cargar la imagen'),
                                );
                              },
                            ),
                          ),
                        ),

                        WidgetsUtil.contenedorPersonalizado(text: 'En clave 2'),
                      ],
                    ),

                    // Fauré, Saint-Saëns, Poulenc
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AboutUs(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: Image.network(
                              'https://drive.google.com/uc?export=view&id=1TDEu1RPXv-V3qipGct5jezKjTeisYFR9',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text('No se pudo cargar la imagen'),
                                );
                              },
                            ),
                          ),
                        ),
                        WidgetsUtil.contenedorPersonalizado(
                          text: 'Fauré,\nSaint-Saëns, Poulenc',
                        ),
                      ],
                    ), // Serenata para cuerdas (Dvorak)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AboutUs(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: Image.network(
                              'https://drive.google.com/uc?export=view&id=1TDEu1RPXv-V3qipGct5jezKjTeisYFR9',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text('No se pudo cargar la imagen'),
                                );
                              },
                            ),
                          ),
                        ),
                        WidgetsUtil.contenedorPersonalizado(
                          text: 'Serenata para cuerdas',
                        ),
                      ],
                    ), // Música y Juguetes
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AboutUs(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: Image.network(
                              'https://drive.google.com/uc?export=view&id=1TDEu1RPXv-V3qipGct5jezKjTeisYFR9',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text('No se pudo cargar la imagen'),
                                );
                              },
                            ),
                          ),
                        ),

                        WidgetsUtil.contenedorPersonalizado(
                          text: 'Música y Juguetes',
                        ),
                      ],
                    ), // Pop y Rock Sinfónico
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AboutUs(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: Image.network(
                              'https://drive.google.com/uc?export=view&id=1TDEu1RPXv-V3qipGct5jezKjTeisYFR9',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text('No se pudo cargar la imagen'),
                                );
                              },
                            ),
                          ),
                        ),

                        WidgetsUtil.contenedorPersonalizado(
                          text: 'Pop y Rock Sinfónico',
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
