// Librerias importadas
import 'package:flutter/material.dart';
import '../customColors/app_colors.dart';
import '../helpScreens/help_about_us.dart';
import '../widgets/widgets_util.dart';

// Clase para mostrar la página de "Sobre Nosotros"
class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    // Valores responsivos basados en el tamaño de pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final tituloFontSize = screenWidth * 0.08;
    final espacioGrande = screenHeight * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nosotros'),
        actions: [
          // Botón de ayuda que lleva a la pantalla HelpAboutUs
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

      // Contenido principal
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 20,
        ),

        child: Column(
          children: [
            // Título de sección
            WidgetsUtil.contenedorPersonalizado(
              text: 'Redes Oficiales',
              fontSize: tituloFontSize,
              fontWeight: FontWeight.bold,
              textoColor: AppColors.titulo,
            ),

            // Línea divisoria decorativa
            Divider(
              height: 0.1,
              indent: screenWidth * 0.15,
              endIndent: screenWidth * 0.15,
              color: AppColors.dividerColor,
              thickness: 2,
            ),

            SizedBox(height: espacioGrande),

            // Imagen del grupo y redes sociales
            Column(
              children: [
                WidgetsUtil.contenedorPersonalizado(
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.15,
                  path: 'assets/images/bannerGrupoTalia.png',
                  fit: BoxFit.contain,
                ),
                SizedBox(height: espacioGrande),

                // Iconos con enlaces a redes sociales oficiales del grupo
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 15,
                  children: [
                    {
                      'path': 'assets/icons/webIcon.png',
                      'url': 'https://www.grupotalia.org/',
                    },
                    {
                      'path': 'assets/icons/facebookIcon.png',
                      'url': 'https://www.facebook.com/GrupoConcertanteTalia/',
                    },
                    {
                      'path': 'assets/icons/twitterIcon.png',
                      'url': 'https://x.com/GrupoTalia',
                    },
                    {
                      'path': 'assets/icons/tiktokIcon.png',
                      'url': 'https://www.tiktok.com/@grupotalia',
                    },
                    {
                      'path': 'assets/icons/instagramIcon.png',
                      'url': 'https://www.instagram.com/grupo.talia/',
                    },
                    {
                      'path': 'assets/icons/youtubeIcon.png',
                      'url': 'https://www.youtube.com/user/grupotalia',
                    },
                  ].map((item) {
                    return OpenLink.socialMediaIcon(
                      path: item['path']!,
                      url: item['url']!,
                      size: screenWidth * 0.1,
                    );
                  }).toList(),
                ),
              ],
            ),

            SizedBox(height: espacioGrande),

            // Segunda sección: Directores
            WidgetsUtil.contenedorPersonalizado(
              text: 'Directores',
              fontSize: tituloFontSize,
              fontWeight: FontWeight.bold,
              textoColor: AppColors.titulo,
            ),

            Divider(
              height: 0.1,
              indent: screenWidth * 0.2,
              endIndent: screenWidth * 0.2,
              color: AppColors.dividerColor,
              thickness: 2,
            ),

            SizedBox(height: espacioGrande),

            // Información sobre Silvia Sanz
            Column(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.2,
                  backgroundImage: const AssetImage('assets/images/silviaimg.png'),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'SILVIA SANZ',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '"DIRECTORA TITULAR"',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Redes de Silvia
                Wrap(
                  spacing: 15,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/facebookIcon.png',
                      url: 'https://www.facebook.com/people/Silvia-Sanz-Torre/100054562743950/',
                      size: screenWidth * 0.1,
                    ),
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/instagramIcon.png',
                      url: 'https://www.instagram.com/silviasanztorre/',
                      size: screenWidth * 0.1,
                    ),
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/twitterIcon.png',
                      url: 'https://x.com/silviasanztorre',
                      size: screenWidth * 0.1,
                    ),
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/linkedinIcon.png',
                      url: 'https://www.linkedin.com/in/silvia-sanz-torre-59764668/',
                      size: screenWidth * 0.1,
                    ),
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/tiktokIcon.png',
                      url: 'https://www.tiktok.com/@silviasanztorre',
                      size: screenWidth * 0.1,
                    ),
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/webIcon.png',
                      url: 'https://www.silviasanz.com/',
                      size: screenWidth * 0.1,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.08),

            // Información sobre Alejandro Vivas
            Column(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.2,
                  backgroundImage: const AssetImage('assets/images/alejandroimg.png'),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'ALEJANDRO VIVAS',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '"DIRECTOR ARTÍSTICO"',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Redes de Alejandro
                Wrap(
                  spacing: 15,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/facebookIcon.png',
                      url: 'https://www.facebook.com/Alejandro-VIVAS-PUIG-1485352031719047/',
                      size: screenWidth * 0.1,
                    ),
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/instagramIcon.png',
                      url: 'https://www.instagram.com/alevivasmusic/',
                      size: screenWidth * 0.1,
                    ),
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/twitterIcon.png',
                      url: 'https://x.com/avivasMusic',
                      size: screenWidth * 0.1,
                    ),
                    OpenLink.socialMediaIcon(
                      path: 'assets/icons/linkedinIcon.png',
                      url: 'https://www.linkedin.com/in/alejandro-vivas-puig-a3152044/',
                      size: screenWidth * 0.1,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.01),

            // Pie de página con política de privacidad, aviso legal, etc.
            WidgetsUtil.pieDePagina(context),
          ],
        ),
      ),
    );
  }
}