// Librerias importadas
import 'package:flutter/material.dart';
import '../customColors/app_colors.dart';
import '../helpScreens/help_contact.dart';
import '../widgets/banner.dart';
import '../widgets/widgets_util.dart';

// Pantalla de contacto con información y enlaces de contacto directo
class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    // Variables responsivas
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.06;
    final bodyFontSize = screenWidth * 0.05;
    final smallFontSize = screenWidth * 0.04;
    final espacio = screenHeight * 0.03;

    // URL de Google Maps con la dirección preconfigurada
    const mapaUrl =
        'https://www.google.com/maps/search/?api=1&query=Av.+del+Veinticinco+de+Septiembre,+2,+28027+Madrid';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Banner personalizado con imagen y botón de ayuda
          BannerPersonalizado(
            titulo: 'Contacto',
            fontSize: screenWidth * 0.05,
            assetImage: 'assets/images/bannerContacto.jpg',
            acciones: [
              IconButton(
                icon: const Icon(Icons.help),
                color: AppColors.appbarIcons,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpContact()),
                  );
                },
              ),
            ],
          ),

          // Contenido de contacto
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: espacio,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título de sección
                  WidgetsUtil.contenedorPersonalizado(
                    text: 'Información de Contacto',
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    textoColor: AppColors.titulo,
                  ),

                  // Línea divisoria decorativa
                  Divider(
                    height: 0.1,
                    indent: screenWidth * 0.1,
                    endIndent: screenWidth * 0.1,
                    thickness: 2,
                    color: AppColors.dividerColor,
                  ),

                  SizedBox(height: espacio),

                  // Dirección con enlace a Google Maps
                  ListTile(
                    leading: Icon(Icons.location_on, color: AppColors.appbar),
                    title: Text(
                      'Avenida Veinticinco de Septiembre, 2',
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '28027 – Madrid',
                      style: TextStyle(
                        fontSize: smallFontSize,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () => OpenLink.abrirEnlace(mapaUrl),
                  ),

                  // Teléfono con funcionalidad de llamada directa
                  ListTile(
                    leading: Icon(Icons.phone, color: AppColors.appbar),
                    title: Text(
                      '+34 91 318 59 28',
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => OpenLink.abrirEnlace('tel:+34913185928'),
                  ),

                  // Correo electrónico con enlace a app de email
                  ListTile(
                    leading: Icon(Icons.email, color: AppColors.appbar),
                    title: Text(
                      'info@grupotalia.org',
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => OpenLink.abrirEnlace('mailto:info@grupotalia.org'),
                  ),

                  // Horario de atención
                  ListTile(
                    leading: Icon(Icons.access_time, color: AppColors.appbar),
                    title: Text(
                      'Horario de oficina',
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Lunes a viernes:\n'
                          '8:00 – 14:00 y 17:00 – 20:00\n\n'
                          'Sábados y domingos:\n'
                          'Ensayos programados',
                      style: TextStyle(
                        fontSize: bodyFontSize * 0.9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: espacio),

                  // Pie de página con enlaces legales
                  WidgetsUtil.pieDePagina(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
