import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../widgets/banner.dart';
import '../widgets/widgets_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BannerPersonalizado(
            titulo: 'Grupo Talía',
            fontSize: 20,
            assetImage: 'assets/images/bannerPrincipal.jpg',
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Grid de accesos
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    children: [
                      _gridItem(
                        context,
                        'Sobre Nosotros',
                        'assets/icons/infoIcon.png',
                        '/about_us',
                      ),
                      _gridItem(
                        context,
                        'Contacto',
                        'assets/icons/contactIcon.png',
                        '/contact',
                      ),
                      _gridItem(
                        context,
                        'Eventos',
                        'assets/icons/eventsIcon.png',
                        '/screens/events',
                      ),
                      _gridItem(
                        context,
                        'Noticias',
                        'assets/icons/newsIcon.png',
                        '/screens/news',
                      ),
                      _gridItem(
                        context,
                        'Ayuda',
                        'assets/icons/supportIcon.png',
                        '/helpScreens/help_screen',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridItem(
    BuildContext context,
    String label,
    String iconPath,
    String route,
  ) {
    return Column(
      children: [
        WidgetsUtil.gridMenu(
          imagePath: iconPath,
          onTap: () => Navigator.pushNamed(context, route),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.texto,
          ),
        ),
      ],
    );
  }
}
