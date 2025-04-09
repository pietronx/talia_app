import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:talia_app/customColors/app_colors.dart';

import '../widgets/widgets_util.dart';

class IconCredits extends StatelessWidget {
  const IconCredits({super.key});

  @override
  Widget build(BuildContext context) {
    final creditos = [
      {
        'icon': 'assets/icons/supportIcon.png',
        'descripcion': 'Icono de Ayuda creado por Freepik',
        'url':
        'https://www.flaticon.es/icono-gratis/servicio-al-cliente_2706962?term=soporte&page=1&position=15&origin=search&related_id=2706962',
      },
      {
        'icon': 'assets/icons/eventsIcon.png',
        'descripcion': 'Icono de Eventos creado por Uniconlabs',
        'url': 'https://www.flaticon.es/icono-gratis/calendario_5656194',
      },
      {
        'icon': 'assets/icons/pastEventsIcon.png',
        'descripcion': 'Icono de Anteriores Eventos creado por Uniconlabs',
        'url': 'https://www.flaticon.es/icono-gratis/calendario_5656753'
      },
      {
        'icon': 'assets/icons/futureEventsIcon.png',
        'descripcion': 'Icono de Próximos Eventos creado por Uniconlabs',
        'url': 'https://www.flaticon.es/icono-gratis/planificador_5656103'
      },
      {
        'icon': 'assets/icons/contactIcon.png',
        'descripcion': 'Icono de Contacto creado por pojok d',
        'url': 'https://www.flaticon.es/icono-gratis/contact-us_9194840',
      },
      {
        'icon': 'assets/icons/facebookIcon.png',
        'descripcion': 'Icono de Facebook creado por Indygo',
        'url':
        'https://www.flaticon.es/icono-gratis/social_15707770?related_id=15707770&origin=style',
      },
      {
        'icon': 'assets/icons/instagramIcon.png',
        'descripcion': 'Icono de Instagram creado por Enamo Studios',
        'url':
        'https://www.flaticon.es/icono-gratis/camara_15047558?term=insta&page=1&position=1&origin=style&related_id=15047558',
      },
      {
        'icon': 'assets/icons/linkedinIcon.png',
        'descripcion': 'Icono de LinkedIn creado por riajulislam',
        'url':
        'https://www.flaticon.es/icono-gratis/linkedin_3536569?term=linkedin&page=1&position=2&origin=style&related_id=3536569',
      },
      {
        'icon': 'assets/icons/infoIcon.png',
        'descripcion': 'Icono de Informacion creado por Mehwish',
        'url':
        'https://www.flaticon.es/icono-gratis/lista_6592963?related_id=6592952&origin=search',
      },
      {
        'icon': 'assets/icons/tiktokIcon.png',
        'descripcion': 'Icono de TikTok creado por Md Tanvirul Haque',
        'url':
        'https://www.flaticon.com/free-icon/tiktok_3669950?term=tik&page=1&position=1&origin=style&related_id=3669950',
      },
      {
        'icon': 'assets/icons/twitterIcon.png',
        'descripcion': 'Icono de Twitter creado por khulqi Rosyid',
        'url':
        'https://www.flaticon.com/free-icon/logos_14417709?term=twitter&page=1&position=12&origin=search',
      },
      {
        'icon': 'assets/icons/webIcon.png',
        'descripcion': 'Icono de Web creado por Anggara',
        'url':
        'https://www.flaticon.es/icono-gratis/sitio-web_8344996?term=web&page=1&position=1&origin=style&related_id=8344996',
      },
      {
        'icon': 'assets/icons/youtubeIcon.png',
        'descripcion': 'Icono de YouTube creado por Md Tanvirul Haque',
        'url':
        'https://www.flaticon.com/free-icon/youtube_3669688?term=youtube&page=1&position=2&origin=style&related_id=3669688',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Créditos de Iconos')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ListView(
          children: [
            const Text(
              'Sobre los iconos utilizados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.texto,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: TextStyle(fontSize: 15, color: AppColors.texto),
                children: [
                  const TextSpan(
                    text:
                    'Todos los iconos que aparecen a continuación han sido '
                        'utilizados de acuerdo con los ',
                  ),
                  TextSpan(
                    text: 'Términos de uso',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        OpenLink.abrirEnlace(
                          'https://www.flaticon.es/legal',
                        );
                      },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ...creditos.map(
                  (item) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                shadowColor: AppColors.titulo,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                color: AppColors.fondo,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset(
                        item['icon'] as String,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['descripcion'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap:
                            () => OpenLink.abrirEnlace(item['url'] as String),
                        child: const Text(
                          'Ver en Flaticon',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}