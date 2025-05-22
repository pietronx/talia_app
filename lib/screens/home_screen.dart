import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../widgets/banner.dart';
import '../widgets/widgets_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.09;
    final verticalPadding = screenHeight * 0.05;

    final items = [
      ['Refrescar', 'assets/icons/refreshIcon.png', 'REFRESCAR'],
      ['Sobre Nosotros', 'assets/icons/infoIcon.png', '/about_us'],
      ['Contacto', 'assets/icons/contactIcon.png', '/contact'],
      ['Eventos', 'assets/icons/eventsIcon.png', '/screens/events'],
      ['Noticias', 'assets/icons/newsIcon.png', '/screens/news'],
      ['Ayuda', 'assets/icons/supportIcon.png', '/helpScreens/help_screen'],
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BannerPersonalizado(
            titulo: 'Grupo Talía',
            fontSize: screenWidth * 0.06,
            assetImage: 'assets/images/bannerPrincipal.jpg',
          ),

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
                mainAxisSpacing: 20,
                crossAxisSpacing: 30,
                childAspectRatio: 0.7,
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        WidgetsUtil.gridMenu(
          imagePath: iconPath,
          onTap: () {
            if (route == 'REFRESCAR') {

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Refrescando contenido...'),
                    duration: Duration(seconds: 2),
                  ),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(titulo: "Grupo Talía"),
                ),
              );
            } else {
              Navigator.pushNamed(context, route);
            }
          },
        ),
        SizedBox(height: screenHeight * 0.01),
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
