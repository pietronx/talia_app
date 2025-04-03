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
      drawer: DrawerUtil.appDrawer(context, currentRoute: 'about'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Banner
            WidgetsUtil.contenedorPersonalizado(
              width: 300,
              height: 140,
              path: 'assets/images/bannerGrupoTalia.png',
            ),
            const SizedBox(height: 40),

            // Webs oficiales
            WidgetsUtil.contenedorPersonalizado(
              text: 'Webs Oficiales',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textoColor: AppColors.titulo,
              fondoColor: AppColors.contenedor,
            ),
            Divider(
              height: 25,
              indent: 55,
              endIndent: 55,
              color: AppColors.drawerCabecera,
              thickness: 2,
            ),
            const SizedBox(height: 20),

            Column(
              children: [
                const Text(
                  'Grupo Talía',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.texto,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  children: List.generate(5, (_) {
                    return OpenLink.socialMediaIcon(
                      icono: Icons.public,
                      url: 'https://www.grupotalia.org/',
                      color: AppColors.appbar,
                    );
                  }),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Column(
              children: [
                const Text(
                  'Silvia Sanz',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.texto,
                  ),
                ),
                const SizedBox(height: 10),
                OpenLink.socialMediaIcon(
                  icono: Icons.public,
                  url: 'https://www.silviasanz.com/',
                  color: AppColors.appbar,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Directores
            WidgetsUtil.contenedorPersonalizado(
              text: 'Directores',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textoColor: AppColors.titulo,
              fondoColor: AppColors.contenedor,
            ),
            Divider(
              height: 25,
              indent: 75,
              endIndent: 75,
              color: AppColors.drawerCabecera,
              thickness: 2,
            ),
            const SizedBox(height: 30),

            // Director 1: Silvia
            _buildDirector(
              nombre: 'SILVIA SANZ',
              cargo: 'DIRECTORA TITULAR',
              imagen: 'assets/images/silviaimg.png',
              redes: {
                'facebook': 'https://www.facebook.com/people/Silvia-Sanz-Torre/100054562743950/',
                'instagram': 'https://www.instagram.com/silviasanztorre/',
                'twitter': 'https://x.com/silviasanztorre',
                'linkedin': 'https://www.linkedin.com/in/silvia-sanz-torre-59764668/',
              },
            ),

            const SizedBox(height: 30),

            // Director 2: Alejandro
            _buildDirector(
              nombre: 'ALEJANDRO VIVAS',
              cargo: 'DIRECTOR ARTÍSTICO',
              imagen: 'assets/images/alejandroimg.png',
              redes: {
                'facebook': 'https://www.facebook.com/Alejandro-VIVAS-PUIG-1485352031719047/',
                'instagram': 'https://www.instagram.com/alevivasmusic/',
                'twitter': 'https://x.com/avivasMusic',
                'linkedin': 'https://www.linkedin.com/in/alejandro-vivas-puig-a3152044/',
              },
            ),

            const SizedBox(height: 40),
            WidgetsUtil.pieDePagina(),
          ],
        ),
      ),
    );
  }

  Widget _buildDirector({
    required String nombre,
    required String cargo,
    required String imagen,
    required Map<String, String> redes,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetsUtil.contenedorPersonalizado(
          width: 100,
          height: 110,
          path: imagen,
          fondoColor: AppColors.contenedor,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetsUtil.contenedorPersonalizado(
                text: '$nombre\n"$cargo"',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                textoColor: Colors.black,
              ),
              const SizedBox(height: 10),
              Center(
                child: Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.center,
                  children: redes.entries.map((entry) {
                    return OpenLink.socialMediaIcon(
                      path: 'assets/icons/${entry.key}Icon.png',
                      url: entry.value,
                      size: 25,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}