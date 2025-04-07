import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_about_us.dart';
import '../widgets/widgets_util.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nosotros'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Webs oficiales
            WidgetsUtil.contenedorPersonalizado(
              text: 'Redes Oficiales',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              textoColor: AppColors.titulo,
            ),

            Divider(
              height: 0.1,
              indent: 55,
              endIndent: 55,
              color: AppColors.drawerCabecera,
              thickness: 2,
            ),
            const SizedBox(height: 30),

            Column(
              children: [

                WidgetsUtil.contenedorPersonalizado(
                  width: 220,
                  height: 100,
                  path: 'assets/images/bannerGrupoTalia.png',
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 30),

                // Redes de Grupo Talía
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 15,
                  children:
                  [
                    {
                      'path': 'assets/icons/webIcon.png',
                      'url': 'https://www.grupotalia.org/',
                    },
                    {
                      'path': 'assets/icons/facebookIcon.png',
                      'url':
                      'https://www.facebook.com/GrupoConcertanteTalia/',
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
                      size: 35,
                    );
                  }).toList(),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Directores
            WidgetsUtil.contenedorPersonalizado(
              text: 'Directores',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              textoColor: AppColors.titulo,
            ),
            Divider(
              height: 0.1,
              indent: 75,
              endIndent: 75,
              color: AppColors.drawerCabecera,
              thickness: 2,
            ),

            const SizedBox(height: 40),

            // Perfil de Silvia Sanz
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage('assets/images/silviaimg.png'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'SILVIA SANZ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '"DIRECTORA TITULAR"',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 15,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    OpenLink.socialMediaIcon(path: 'assets/icons/facebookIcon.png', url: 'https://www.facebook.com/people/Silvia-Sanz-Torre/100054562743950/', size: 30),
                    OpenLink.socialMediaIcon(path: 'assets/icons/instagramIcon.png', url: 'https://www.instagram.com/silviasanztorre/', size: 30),
                    OpenLink.socialMediaIcon(path: 'assets/icons/twitterIcon.png', url: 'https://x.com/silviasanztorre', size: 30),
                    OpenLink.socialMediaIcon(path: 'assets/icons/linkedinIcon.png', url: 'https://www.linkedin.com/in/silvia-sanz-torre-59764668/', size: 30),
                    OpenLink.socialMediaIcon(path: 'assets/icons/tiktokIcon.png', url: 'https://www.tiktok.com/@silviasanztorre', size: 30),
                    OpenLink.socialMediaIcon(path: 'assets/icons/webIcon.png', url: 'https://www.silviasanz.com/', size: 30),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 50),

            // Perfil de Alejandro
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage('assets/images/alejandroimg.png'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'ALEJANDRO VIVAS',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '"DIRECTOR ARTÍSTICO"',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 15,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    OpenLink.socialMediaIcon(path: 'assets/icons/facebookIcon.png', url: 'https://www.facebook.com/Alejandro-VIVAS-PUIG-1485352031719047/', size: 30),
                    OpenLink.socialMediaIcon(path: 'assets/icons/instagramIcon.png', url: 'https://www.instagram.com/alevivasmusic/', size: 30),
                    OpenLink.socialMediaIcon(path: 'assets/icons/twitterIcon.png', url: 'https://x.com/avivasMusic', size: 30),
                    OpenLink.socialMediaIcon(path: 'assets/icons/linkedinIcon.png', url: 'https://www.linkedin.com/in/alejandro-vivas-puig-a3152044/', size: 30),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Politica y Privacidad
            WidgetsUtil.pieDePagina(),
          ],
        ),
      ),
    );
  }
}