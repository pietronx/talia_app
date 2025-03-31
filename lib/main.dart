import 'package:flutter/material.dart';
import 'package:talia_app/widgets/widgets_util.dart';

import 'customColors/app_colors.dart';

void main() {
  runApp(const MyApp());
}

// Clase principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talia Group App',
      theme: ThemeData(
        primaryColor: AppColors.appbar,
        scaffoldBackgroundColor: AppColors.fondo,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.texto, fontSize: 16),
          bodyMedium: TextStyle(color: AppColors.texto, fontSize: 14),
          titleLarge: TextStyle(
            color: AppColors.titulo,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(color: AppColors.appbar, fontSize: 22),
        ),
        appBarTheme: const AppBarTheme(
          color: AppColors.appbar,
          iconTheme: IconThemeData(color: AppColors.appbarIcons),
          titleTextStyle: TextStyle(
            color: AppColors.appbarTitulo,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const PantallaPrincipal(titulo: 'Grupo Talia'),
    );
  }
}

// ----------------------> Pantalla principal <----------------------\\
class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ToolBar
      appBar: AppBar(
        title: Text(
          titulo,
          style: const TextStyle(color: AppColors.appbarTitulo),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: null,
            icon: const Icon(Icons.search),
            color: AppColors.appbarIcons, // Color del ícono
          ),
          IconButton(
            onPressed: null,
            icon: const Icon(Icons.shopping_cart),
            color: AppColors.appbarIcons, // Color del ícono
          ),
        ],
      ),
      // Cuerpo de la pantalla
      body: const Center(child: Text('Bienvenido a la aplicación')),
      drawer: Drawer(
        child: Container(
          color: AppColors.drawerFondo,
          child: Column(
            children: <Widget>[
              // Encabezado del Drawer con tamaño fijo
              SizedBox(
                child: Container(
                  padding: const EdgeInsets.only(top: 60, bottom: 30),
                  width: double.infinity,
                  color: AppColors.drawerCabecera,
                  alignment: Alignment.center,
                  child: const Text(
                    'Menu',
                    style: TextStyle(
                      color: AppColors.drawerTitulo,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Lista de opciones del Drawer
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  // Evita espaciados
                  padding: EdgeInsets.only(top: 10),
                  children: [
                    _barraLateral(context, 'Sobre Nosotros', const AboutUs()),
                    _divisores(),
                    _barraLateral(context, 'Contacto', const Contact()),
                    _divisores(),
                    _barraLateral(context, 'Eventos', null),
                    _divisores(),
                    _barraLateral(context, 'Abonos', null),
                    _divisores(),
                    _barraLateral(context, 'Cesta', null),
                    _divisores(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Función para construir los elementos de la lista
ListTile _barraLateral(BuildContext context, String title, Widget? page) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    onTap: () {
      if (page != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      } else {
        Navigator.pop(context);
      }
    },
  );
}

// Función para construir los separadores
Divider _divisores() {
  return const Divider(color: AppColors.drawerCabecera, thickness: 1);
}

// ----------------------> Pantalla Sobre Nosotros <----------------------\\

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre Nosotros')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Banner de la empresa
                WidgetsUtil.contenedorPersonalizado(
                  width: 300,
                  height: 140,
                  path: 'assets/images/bannerGrupoTalia.png',
                ),

                SizedBox(height: 50),

                // Titulo Webs Oficiales
                WidgetsUtil.contenedorPersonalizado(
                  text: 'Webs Oficiales',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textoColor: AppColors.titulo,
                  fondoColor: AppColors.contenedor,
                ),

                // Divisor
                Divider(
                  height: 25,
                  indent: 55,
                  endIndent: 55,
                  color: AppColors.drawerCabecera,
                  thickness: 2,
                ),

                SizedBox(height: 30), // Web Oficiales - Grupo Talía

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Centra todo el contenido del Row principal
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Grupo Talía
                    Row(
                      children: [
                        Text(
                          'Grupo Talía',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.texto,
                          ),
                        ),

                        SizedBox(width: 1),

                        // Espacio entre texto e icono
                        OpenLink.socialMediaIcon(
                          icono: Icons.public,
                          url: 'https://www.grupotalia.org/',
                          color: AppColors.appbar,
                        ),
                      ],
                    ),

                    Container(width: 1, height: 30, color: AppColors.appbar),

                    SizedBox(width: 10),

                    // Silvia Sanz
                    Row(
                      children: [
                        Text(
                          'Silvia Sanz',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.texto,
                          ),
                        ),
                        SizedBox(width: 1),
                        // Espacio entre texto e icono
                        OpenLink.socialMediaIcon(
                          icono: Icons.public,
                          url: 'https://www.silviasanz.com/',
                          color: AppColors.appbar,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 40),

                // Titulo Directores
                WidgetsUtil.contenedorPersonalizado(
                  text: 'Directores',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textoColor: AppColors.titulo,
                  fondoColor: AppColors.contenedor,
                ),

                // Divisor
                Divider(
                  height: 25,
                  indent: 75,
                  endIndent: 75,
                  color: AppColors.drawerCabecera,
                  thickness: 2,
                ),

                SizedBox(height: 40),

                // Director 1
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // Director 1 - Imagen
                  children: [
                    WidgetsUtil.contenedorPersonalizado(
                      width: 100,
                      height: 110,
                      path: 'assets/images/silviaimg.png',
                      fondoColor: AppColors.contenedor,
                    ),

                    SizedBox(width: 20),
                    // Separador entre imagen y texto

                    // Director 1 - Texto
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetsUtil.contenedorPersonalizado(
                            text: 'SILVIA SANZ\n"DIRECTORA TITULAR"',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            textoColor: Colors.black,
                          ),

                          SizedBox(height: 0),

                          // Director 1 - Iconos y Enlaces
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 25),
                              OpenLink.socialMediaIcon(
                                path: 'assets/icons/facebookIcon.png',
                                url:
                                    'https://www.facebook.com/people/Silvia-Sanz-Torre/100054562743950/#',
                              ),
                              SizedBox(width: 10),
                              OpenLink.socialMediaIcon(
                                path: 'assets/icons/instagram.png',
                                url:
                                    'https://www.instagram.com/silviasanztorre/#',
                              ),
                              SizedBox(width: 10),
                              OpenLink.socialMediaIcon(
                                path: 'assets/icons/twitterIcon.png',
                                url: 'https://x.com/silviasanztorre',
                              ),
                              SizedBox(width: 10),
                              OpenLink.socialMediaIcon(
                                path: 'assets/icons/linkedinIcon.png',
                                url:
                                    'https://www.linkedin.com/in/silvia-sanz-torre-59764668/',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40), // Separador entre directores
                // Director 2
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // Director 2 - Imagen
                  children: [
                    // Imagen a la izquierda
                    WidgetsUtil.contenedorPersonalizado(
                      width: 100,
                      height: 110,
                      path: 'assets/images/alejandroimg.png',
                      fondoColor: AppColors.contenedor,
                    ),

                    SizedBox(width: 20), // Separador entre imagen y texto
                    // Director 2 - Texto
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetsUtil.contenedorPersonalizado(
                            text: 'ALEJANDRO VIVAS\n"DIRECTOR ARTÍSTICO"',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            textoColor: Colors.black,
                          ),

                          SizedBox(height: 0),

                          // Director 2 - Iconos y Enlaces
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 25),
                              OpenLink.socialMediaIcon(
                                path: 'assets/icons/facebookIcon.png',
                                url:
                                    'https://www.facebook.com/Alejandro-VIVAS-PUIG-1485352031719047/',
                              ),
                              SizedBox(width: 10),
                              OpenLink.socialMediaIcon(
                                path: 'assets/icons/instagram.png',
                                url:
                                    'https://www.instagram.com/alevivasmusic/#',
                              ),
                              SizedBox(width: 10),
                              OpenLink.socialMediaIcon(
                                path: 'assets/icons/twitterIcon.png',
                                url: 'https://x.com/avivasMusic',
                              ),
                              SizedBox(width: 10),
                              OpenLink.socialMediaIcon(
                                path: 'assets/icons/linkedinIcon.png',
                                url:
                                    'https://www.linkedin.com/in/alejandro-vivas-puig-a3152044/',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Apartado de copyright y derechos reservados
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [

                      SizedBox(height: 40),

                      Divider(
                        indent: 10,
                        endIndent: 10,
                        color: AppColors.drawerCabecera,
                        thickness: 1,
                      ),

                      SizedBox(height: 16),
                      // Espacio después del Divider

                      // Texto de copyright
                      Text(
                        '© ${DateTime.now().year} Grupo Talía',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),

                      // Texto de derechos reservados
                      Text(
                        'Todos los derechos reservados',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),

                      SizedBox(height: 16),

                      // Enlaces de privacidad y legal
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Politica de privacidad
                        children: [
                          TextButton(
                            onPressed:
                                () => OpenLink.abrirEnlace(
                              'https://www.grupotalia.org/privacidad/',
                            ),
                            child: Text(
                              'Política de privacidad',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),

                          SizedBox(height: 1),

                          // Aviso Legal
                          TextButton(
                            onPressed:
                                () => OpenLink.abrirEnlace(
                              'https://www.grupotalia.org/avisolegal/',
                            ),
                            child: Text(
                              'Aviso Legal',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------> Pantalla Contacto <----------------------\\

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacto')),
      body: SingleChildScrollView(
        child: Padding(
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

                SizedBox(height: 20),

                // Espacio de Separación
                WidgetsUtil.contenedorPersonalizado(
                  text:
                      'Av. del Veinticinco de Septiembre, 2\n'
                      '28027 Madrid\n'
                      'Teléfono: +34 91 318 59 28\n'
                      'Correo: info@grupotalia.org',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 2,
                  fondoColor: AppColors.contenedor,
                  textoColor: Colors.black,
                ),

                // Apartado de copyright y derechos reservados
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [

                      SizedBox(height: 40),

                      Divider(
                        indent: 10,
                        endIndent: 10,
                        color: AppColors.drawerCabecera,
                        thickness: 1,
                      ),

                      SizedBox(height: 16),
                      // Espacio después del Divider

                      // Texto de copyright
                      Text(
                        '© ${DateTime.now().year} Grupo Talía',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),

                      // Texto de derechos reservados
                      Text(
                        'Todos los derechos reservados',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),

                      SizedBox(height: 16),

                      // Enlaces de privacidad y legal
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Politica de privacidad
                        children: [
                          TextButton(
                            onPressed:
                                () => OpenLink.abrirEnlace(
                              'https://www.grupotalia.org/privacidad/',
                            ),
                            child: Text(
                              'Política de privacidad',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),

                          SizedBox(height: 1),

                          // Aviso Legal
                          TextButton(
                            onPressed:
                                () => OpenLink.abrirEnlace(
                              'https://www.grupotalia.org/avisolegal/',
                            ),
                            child: Text(
                              'Aviso Legal',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------> Pantalla Eventos <----------------------\\

// ----------------------> Pantalla Abonos <----------------------\\

// ----------------------> Pantalla Cesta <----------------------\\
