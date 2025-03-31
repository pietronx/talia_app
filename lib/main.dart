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
      title: 'Ejemplo 1',
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
      //--> Codigo Antiguo
      /*

      <---------------------------- Codigo antiguo ---------------------------->

      drawer: Drawer(
        child: Column(
          children: <Widget>[
            // Encabezado del Drawer
            Container(
              width: double.infinity,
              color: AppColors.drawerCabecera,
              padding: const EdgeInsets.only(top: 60, bottom: 20),
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

            // Cuerpo del Drawer
            Expanded(
              child: Container(
                color: AppColors.drawerFondo,
                child: ListView(
                  children: [
                    ListTile(
                      //--> Botón de Sobre Nosotros
                      title: const Text(
                        'Sobre Nosotros',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutUs(),
                          ),
                        );
                      },
                    ),

                    const Divider(
                      color: AppColors.drawerCabecera, // Color de la línea
                      thickness: 1, // Grosor de la línea
                    ),

                    ListTile(
                      //--> Botón de Contacto
                      title: const Text(
                        'Contacto',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Contact(),
                          ),
                        );
                      },
                    ),

                    const Divider(
                      color: AppColors.drawerCabecera,
                      thickness: 1,
                    ),

                    ListTile(
                      //--> Botón de Eventos
                      title: const Text(
                        'Eventos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    const Divider(
                      color: AppColors.drawerCabecera,
                      thickness: 1,
                    ),

                    ListTile(
                      //--> Botón de Abonos
                      title: const Text(
                        'Abonos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    const Divider(
                      color: AppColors.drawerCabecera,
                      thickness: 1,
                    ),

                    ListTile(
                      //--> Botón de Cesta
                      title: const Text(
                        'Cesta',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    const Divider(
                      color: AppColors.drawerCabecera,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
       */
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

  /* Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre Nosotros')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Espacio de Separación
                WidgetsUtil.contenedorPersonalizado(
                  text: 'Directores',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textoColor: AppColors.titulo,
                ),

                SizedBox(height: 20), // Separador entre titulo y texto
                // Elemento para scrollear de manera horizontal
                Row(
                  children: [
                    WidgetsUtil.contenedorPersonalizado(
                      width: 110,
                      height: 110,
                      path: 'assets/images/imagenuno.png',
                      fondoColor: AppColors.contenedor,
                    ),

                    SizedBox(width: 20),

                    // Separador entre imagen y texto
                    WidgetsUtil.contenedorPersonalizado(
                      text:
                          'SILVIA SANZ\n'
                          'DIRECTORA TITULAR',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textoColor: Colors.black,
                    ),

                    SizedBox(height: 20),
                    // Contenedor de iconos
                    Row(
                      children: [
                        SocialIcon.socialMediaIcon(
                          icono: Icons.facebook,
                          url: 'https://www.facebook.com/silviasanz',
                        ),
                        SocialIcon.socialMediaIcon(
                          icono: Icons.mail,
                          url: 'mailto:silvia@correo.com',
                        ),
                        SocialIcon.socialMediaIcon(
                          icono: Icons.public,
                          url: 'https://www.sitio-web.com',
                        ),
                        SocialIcon.socialMediaIcon(
                          icono: Icons.camera_alt,
                          url: 'https://www.instagram.com/silviasanz',
                        ),
                      ],
                    ),

                    SizedBox(height: 30), // Separador entre directores

                    Row(
                      children: [
                        WidgetsUtil.contenedorPersonalizado(
                          width: 110,
                          height: 110,
                          path: 'assets/images/imagendos.png',
                          fondoColor: AppColors.contenedor,
                        ),

                        SizedBox(width: 20),

                        WidgetsUtil.contenedorPersonalizado(
                          text:
                              'ALEJANDRO VIVAS\n'
                              'DIRECTOR ARTÍSTICO',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          textoColor: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
   */
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
                // Espacio de Separación
                WidgetsUtil.contenedorPersonalizado(
                  text: 'Directores',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textoColor: AppColors.titulo,
                ),

                SizedBox(height: 20), // Separador entre titulo y texto

                // Elemento para mostrar imagen, texto e iconos
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Alineamos los elementos en la parte superior
                  children: [
                    // Imagen a la izquierda
                    WidgetsUtil.contenedorPersonalizado(
                      width: 110,
                      height: 110,
                      path: 'assets/images/imagendos.png',
                      fondoColor: AppColors.contenedor,
                    ),

                    SizedBox(width: 20), // Separador entre imagen y texto

                    // Contenedor para el texto
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetsUtil.contenedorPersonalizado(
                            text: 'SILVIA SANZ\nDIRECTORA TITULAR',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            textoColor: Colors.black,
                          ),

                          SizedBox(height: 1),

                          /*
                          // Contenedor de iconos
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SocialIcon.socialMediaIcon(
                                icono: Icons.facebook,
                                url: 'https://flutter.dev',
                              ),
                              SizedBox(width: 10),
                              SocialIcon.socialMediaIcon(
                                path: 'assets/icons/instagram.png',
                                url: 'https://www.instagram.com/silviasanztorre/#',
                              ),
                            ],
                          ),
                          */
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30), // Separador entre directores

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Alineamos los elementos en la parte superior
                  children: [
                    // Imagen a la izquierda
                    WidgetsUtil.contenedorPersonalizado(
                      width: 110,
                      height: 110,
                      path: 'assets/images/imagendos.png',
                      fondoColor: AppColors.contenedor,
                    ),

                    SizedBox(width: 20), // Separador entre imagen y texto

                    // Contenedor para el texto
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetsUtil.contenedorPersonalizado(
                            text: 'ALEJANDRO VIVAS\nDIRECTOR ARTÍSTICO',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            textoColor: Colors.black,
                          ),

                          SizedBox(height: 1),
                          /*
                          // Contenedor de iconos
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SocialIcon.socialMediaIcon(
                                icono: Icons.facebook,
                                url: 'https://www.facebook.com/alejandrovivas',
                              ),
                              SizedBox(width: 10),
                              SocialIcon.socialMediaIcon(
                                icono: Icons.camera_alt,
                                url: 'https://www.instagram.com/alejandrovivas',
                              ),
                            ],
                          ),
                          */
                        ],
                      ),
                    ),
                  ],
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
/*

    <---------------------------- Codigo antiguo ---------------------------->

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
                _WidgetsUtil.contenedorPersonalizado(
                  'Información de Contacto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),

                const SizedBox(height: 20),

                // Espacio de Separacion
                _WidgetsUtil.contenedorPersonalizado(
                  'Av. del Veinticinco de Septiembre, 2\n'
                  '28027 Madrid\n'
                  'Teléfono: +34 91 318 59 28\n'
                  'Correo: info@grupotalia.org',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 2,
                ),

                const SizedBox(height: 20),
                // Espacio de Separacion
                // "ScrollView" horizontal
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                  child: Row(
                    // Usa Row para alinear los elementos en línea horizontal
                    children: [
                      _contenedor(100, 100, 'assets/images/imagenuno.png'),

                      const SizedBox(width: 20),

                      _WidgetsUtil.contenedorPersonalizado(
                        'SILVIA SANZ\n'
                        'DIRECTORA TITULAR\n'
                        'Apasionada de la música\n y trabajadora incansable\n'
                        'Siempre con una partitura en sus manos',
                        fontSize: 14,
                        fontWeight: FontWeight.normal
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

  // Función para crear los contenedores de imagenes
  Widget _contenedor(double width, double height, String path) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.contenedor,
        borderRadius: BorderRadius.circular(10),
        // Bordes redondeados opcionales
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100), // Opacidad del sombreado
            blurRadius: 10, // Difuminacion del sombreado
            spreadRadius: 2, // Tamaño del sombreado
            offset: const Offset(0, 2), // Desplazamiento del sombreado
          ),
        ],
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }

  // Función para crear los recuadros de texto
  // Constructor
  Widget _WidgetsUtil.contenedorPersonalizado (String text, {
    required double fontSize,
    required FontWeight fontWeight,
    double? height, // Interlineado
  }) {
    // Creacion del contenedor con el texto
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // Bordes redondeados opcionales
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100), // Opacidad del sombreado
            blurRadius: 10, // Difuminacion del sombreado
            spreadRadius: 2, // Tamaño del sombreado
            offset: const Offset(0, 2), // Desplazamiento del sombreado
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
 */

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

                SizedBox(height: 30),

                // Espacio de Separación
                WidgetsUtil.contenedorPersonalizado(
                  text: 'Directores',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textoColor: AppColors.titulo,
                ),

                SizedBox(height: 20),
                // Espacio de Separación

                // Elemento para scrollear de manera horizontal
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                  child: Row(
                    children: [
                      WidgetsUtil.contenedorPersonalizado(
                        width: 110,
                        height: 110,
                        path: 'assets/images/imagenuno.png',
                        fondoColor: AppColors.contenedor,
                      ),

                      SizedBox(width: 20),

                      WidgetsUtil.contenedorPersonalizado(
                        text:
                        'SILVIA SANZ\n'
                            'DIRECTORA TITULAR',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textoColor: Colors.black,
                      ),

                      SizedBox(width: 20),

                      WidgetsUtil.contenedorPersonalizado(
                        width: 110,
                        height: 110,
                        path: 'assets/images/imagendos.png',
                        fondoColor: AppColors.contenedor,
                      ),

                      SizedBox(width: 20),

                      WidgetsUtil.contenedorPersonalizado(
                        text:
                        'ALEJANDRO VIVAS\n'
                            'DIRECTOR ARTÍSTICO',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textoColor: Colors.black,
                      ),
                      SizedBox(width: 10),
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
/*
  // Función unificada para crear los recuadros con texto o imagen
  Widget WidgetsUtil.contenedorPersonalizado({
    double? width,
    double? height,
    String? text,
    String? path,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    double? textHeight, // Interlineado
    Color? fondoColor,
    Color? textoColor,
  }) {
    // Si se proporciona una ruta de imagen
    if (path != null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: fondoColor ?? Colors.transparent,
          // Color de fondo opcional
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        ),
      );
    }

    // Si no se proporciona ruta de imagen, se muestra el texto
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: fondoColor ?? AppColors.fondo,
        borderRadius: BorderRadius.circular(10),
        // Eliminar las sombras si no se pasa el fondoColor
        boxShadow:
            fondoColor == null
                ? [] // Sin sombra si no hay fondoColor
                : [
                  BoxShadow(
                    color: Colors.black.withAlpha(
                      100,
                    ), // Opacidad del sombreado
                    blurRadius: 10, // Difuminación del sombreado
                    spreadRadius: 2, // Tamaño del sombreado
                    offset: const Offset(0, 2), // Desplazamiento del sombreado
                  ),
                ],
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textoColor ?? Colors.black,
          height: textHeight, // Interlineado si se pasa
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
*/
// Pantalla Eventos

// Pantalla Abonos

// Pantalla Cesta