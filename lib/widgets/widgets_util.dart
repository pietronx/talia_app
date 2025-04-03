import 'dart:io' show Platform;

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../screens/about_us.dart';
import '../screens/calendar.dart';
import '../screens/contact.dart';
import '../screens/pantalla_principal.dart';

// Función para crear los recuadros con texto o imagen
class WidgetsUtil {
  static Widget contenedorPersonalizado({
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
    if (path != null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: fondoColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: fondoColor ?? AppColors.fondo,
        borderRadius: BorderRadius.circular(10),
        boxShadow:
            fondoColor == null
                ? []
                : [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textoColor ?? Colors.black,
          height: textHeight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget bloqueAyuda({
    IconData? icono,
    required String titulo,
    required String descripcion,
    List<String>? puntos,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icono != null) Icon(icono, size: 28, color: AppColors.appbar),
              SizedBox(width: icono != null ? 10 : 0),
              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(descripcion, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          ...(puntos ?? []).map(
            (p) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 16)),
                Expanded(child: Text(p, style: const TextStyle(fontSize: 16))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget pieDePagina() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Divider(
          indent: 10,
          endIndent: 10,
          color: AppColors.drawerCabecera,
          thickness: 1,
        ),
        const SizedBox(height: 16),
        Text(
          '© ${DateTime.now().year} Grupo Talía',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        Text(
          'Todos los derechos reservados',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 1),
        TextButton(
          onPressed: () => OpenLink.abrirEnlace('https://www.grupotalia.org/privacidad/'),
          child: Text(
            'Política de privacidad',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ),
        TextButton(
          onPressed: () => OpenLink.abrirEnlace('https://www.grupotalia.org/avisolegal/'),
          child: Text(
            'Aviso Legal',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}

class OpenLink {
  static Widget socialMediaIcon({
    IconData? icono,
    String? path,
    required String url,
    Color color = AppColors.appbar,
    double size = 24.0,
  }) {
    if (path != null) {
      return GestureDetector(
        onTap: () => abrirEnlace(url),
        child: Image.asset(path, width: size, height: size, color: color),
      );
    }

    return IconButton(
      icon: Icon(icono, color: color),
      onPressed: () => abrirEnlace(url),
      iconSize: size,
    );
  }

  static void abrirEnlace(String url) async {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(action: 'action_view', data: url);
      try {
        await intent.launch();
      } catch (e) {
        debugPrint('Error al intentar abrir el enlace: $e');
      }
    } else {
      debugPrint('Este método solo funciona en Android por ahora');
    }
  }
}

class DrawerUtil {
  static Divider divisor() {
    return const Divider(color: AppColors.drawerCabecera, thickness: 1);
  }

  static Widget appDrawer(
    BuildContext context, {
    required String currentRoute,
  }) {
    return Drawer(
      child: Container(
        color: AppColors.drawerFondo,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.drawerCabecera,
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Column(
                children: [
                  // Imagen superior del drawer
                  SizedBox(
                    height: 150,
                    child: Image.asset(
                      'assets/images/bannerGrupoTalia.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Menú',
                    style: TextStyle(
                      color: AppColors.drawerTitulo,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 10),
                children: [
                  if (currentRoute != 'home') ...[
                    ListTile(
                      title: const Text(
                        'Inicio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => const PantallaPrincipal(
                                  titulo: 'Grupo Talia',
                                ),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    DrawerUtil.divisor(),
                  ],

                  if (currentRoute != 'aboutus') ...[
                    ListTile(
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
                          MaterialPageRoute(builder: (_) => const AboutUs()),
                        );
                      },
                    ),
                    DrawerUtil.divisor(),
                  ],

                  if (currentRoute != 'contact') ...[
                    ListTile(
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
                          MaterialPageRoute(builder: (_) => const Contact()),
                        );
                      },
                    ),
                    DrawerUtil.divisor(),
                  ],

                  if (currentRoute != 'calendar') ...[
                    ListTile(
                      title: const Text('Calendario', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const Calendar()));
                      },
                    ),
                    DrawerUtil.divisor(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
