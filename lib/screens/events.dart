import 'package:flutter/material.dart';
import 'package:talia_app/helpScreens/help_events.dart';

import '../customColors/app_colors.dart';
import '../widgets/widgets_util.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpEvents()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Muestra dos columnas
                  crossAxisCount: 2,

                  // Espacio horizontal entre columnas
                  crossAxisSpacing: 35,

                  // Relación ancho/alto de cada celda: 0.7 = más alta que ancha
                  childAspectRatio: 0.6,
                  children: [
                    Column(
                      children: [
                        WidgetsUtil.gridMenu(
                          imagePath: 'assets/icons/pastEventsIcon.png',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/screens/previousEvents',
                              ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Anteriores Eventos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.texto,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        WidgetsUtil.gridMenu(
                          imagePath: 'assets/icons/futureEventsIcon.png',
                          onTap:
                              () => Navigator.pushNamed(
                            context,
                            '/screens/nextEvents',
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Próximos Eventos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
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
