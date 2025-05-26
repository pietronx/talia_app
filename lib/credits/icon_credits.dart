import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:talia_app/customColors/app_colors.dart';
import '../widgets/widgets_util.dart';

class IconCredits extends StatelessWidget {
  const IconCredits({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.06;
    final verticalPadding = screenHeight * 0.03;
    final titleFontSize = screenWidth * 0.06;
    final bodyFontSize = screenWidth * 0.042;
    final spacing = screenHeight * 0.015;
    final iconSize = screenWidth * 0.12;

    final creditos = [
      {
        'icon': 'assets/icons/helpIcon.png',
        'descripcion': 'Icono de Ayuda creado por Freepik',
        'url': 'https://www.flaticon.es/icono-gratis/servicio-al-cliente_2706962?term=soporte&page=1&position=15&origin=search&related_id=2706962',
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
        'icon': 'assets/icons/infoIcon.png',
        'descripcion': 'Icono de Información creado por Mehwish',
        'url': 'https://www.flaticon.es/icono-gratis/lista_6592963?related_id=6592952&origin=search',
      },
      {
        'icon' : 'assets/icons/refreshIcon.png',
        'descripcion': 'Icono de Recargar creado por mavadee',
        'url': 'https://www.flaticon.es/icono-gratis/recargar_3580324?related_id=3580284&origin=search&k=1747900843411&log-in=google',
      },
      {
        'icon': 'assets/icons/newsIcon.png',
        'descripcion': 'Icono de Noticias creado por Freepik',
        'url': 'https://www.flaticon.es/icono-gratis/periodico_2965879?term=noticias&related_id=2965879'
      },
      {
        'icon': 'assets/icons/facebookIcon.png',
        'descripcion': 'Icono de Facebook creado por Indygo',
        'url': 'https://www.flaticon.es/icono-gratis/social_15707770?related_id=15707770&origin=style',
      },
      {
        'icon': 'assets/icons/instagramIcon.png',
        'descripcion': 'Icono de Instagram creado por Enamo Studios',
        'url': 'https://www.flaticon.es/icono-gratis/camara_15047558?term=insta&page=1&position=1&origin=style&related_id=15047558',
      },
      {
        'icon': 'assets/icons/linkedinIcon.png',
        'descripcion': 'Icono de LinkedIn creado por riajulislam',
        'url': 'https://www.flaticon.es/icono-gratis/linkedin_3536569?term=linkedin&page=1&position=2&origin=style&related_id=3536569',
      },
      {
        'icon': 'assets/icons/tiktokIcon.png',
        'descripcion': 'Icono de TikTok creado por Md Tanvirul Haque',
        'url': 'https://www.flaticon.com/free-icon/tiktok_3669950?term=tik&page=1&position=1&origin=style&related_id=3669950',
      },
      {
        'icon': 'assets/icons/twitterIcon.png',
        'descripcion': 'Icono de Twitter creado por khulqi Rosyid',
        'url': 'https://www.flaticon.com/free-icon/logos_14417709?term=twitter&page=1&position=12&origin=search',
      },
      {
        'icon': 'assets/icons/webIcon.png',
        'descripcion': 'Icono de Web creado por Anggara',
        'url': 'https://www.flaticon.es/icono-gratis/sitio-web_8344996?term=web&page=1&position=1&origin=style&related_id=8344996',
      },
      {
        'icon': 'assets/icons/youtubeIcon.png',
        'descripcion': 'Icono de YouTube creado por Md Tanvirul Haque',
        'url': 'https://www.flaticon.com/free-icon/youtube_3669688?term=youtube&page=1&position=2&origin=style&related_id=3669688',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Créditos de Iconos')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: ListView(
          children: [
            Text(
              'Sobre los iconos utilizados',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.texto,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: spacing * 1),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(fontSize: bodyFontSize, color: AppColors.texto),
                children: [
                  const TextSpan(
                    text: 'Todos los iconos que aparecen a continuación han sido utilizados de acuerdo con los ',
                  ),
                  TextSpan(
                    text: 'Términos de uso',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => OpenLink.abrirEnlace('https://www.flaticon.es/legal'),
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing * 2),
            ...creditos.map(
                  (item) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                shadowColor: AppColors.titulo,
                margin: EdgeInsets.symmetric(vertical: spacing * 1.2, horizontal: spacing * 0.25),
                color: AppColors.fondo,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      Image.asset(
                        item['icon'] as String,
                        width: iconSize,
                        height: iconSize,
                      ),
                      SizedBox(height: spacing),
                      Text(
                        item['descripcion'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: bodyFontSize),
                      ),
                      SizedBox(height: spacing * 0.5),
                      GestureDetector(
                        onTap: () => OpenLink.abrirEnlace(item['url'] as String),
                        child: Text(
                          'Ver en Flaticon',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: bodyFontSize,
                            decoration: TextDecoration.underline,
                          ),
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