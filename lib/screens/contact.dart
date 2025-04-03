import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_contact.dart';
import '../widgets/widgets_util.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    final String mapaUrl =
        'https://www.google.com/maps/search/?api=1&query=Av.+del+Veinticinco+de+Septiembre,+2,+28027+Madrid';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacto'),
        actions: <Widget>[
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

      drawer: DrawerUtil.appDrawer(context, currentRoute: 'contact'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetsUtil.contenedorPersonalizado(
                text: 'Información de Contacto',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textoColor: AppColors.titulo,
              ),

              ListTile(
                leading: Icon(Icons.location_on, color: AppColors.appbar),
                title: Text(
                  'Avenida Veinticinco de Septiembre, 2',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '28027 – Madrid',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                onTap: () => OpenLink.abrirEnlace(mapaUrl),
              ),

              ListTile(
                leading: Icon(Icons.phone, color: AppColors.appbar),
                title: Text(
                  '+34 91 318 59 28',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () => OpenLink.abrirEnlace('tel:+34913185928'),
              ),

              ListTile(
                leading: Icon(Icons.email, color: AppColors.appbar),
                title: Text(
                  'info@grupotalia.org',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () => OpenLink.abrirEnlace('mailto:info@grupotalia.org'),
              ),

              ListTile(
                leading: Icon(Icons.access_time, color: AppColors.appbar),
                title: Text(
                  'Horario de oficina',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Lunes a viernes:\n'
                      '8:00 – 14:00 y 17:00 – 20:00\n\n'
                      'Sábados y domingos:\n'
                      'Ensayos programados',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),

              // Apartado de copyright y derechos reservados
              WidgetsUtil.pieDePagina(),
            ],
          ),
        ),
      ),
    );
  }
}
