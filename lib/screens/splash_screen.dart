// Librerías necesarias para la lógica de arranque
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talia_app/customColors/app_colors.dart';
import 'package:talia_app/widgets/loading_animation.dart';

import 'home_screen.dart';
import 'offline_screen.dart';

// Pantalla de carga inicial que verifica si hay conexión antes de entrar a la app
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    inicializarApp(); // Llama a la lógica de arranque cuando el widget se carga
  }

  // Función que controla la transición según el estado de la conexión
  Future<void> inicializarApp() async {
    try {
      debugPrint("Inicializando...");

      // Espera artificial para mostrar la animación unos segundos
      await Future.delayed(const Duration(seconds: 2));
      debugPrint("Pasado delay");

      final conectado = await comprobarConexion();
      debugPrint("¿Hay conexión? $conectado");

      // Navegación condicional según si hay conexión
      if (conectado) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(titulo: 'Pantalla de Carga'),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NoConnection()),
        );
      }
    } catch (e) {
      debugPrint('Error en inicializarApp: $e');
    }
  }

  // Verifica conectividad haciendo un ping simple a Google
  Future<bool> comprobarConexion() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // ignore_for_file: avoid_print, use_build_context_synchronously
  @override
  Widget build(BuildContext context) {
    // Muestra una animación de carga mientras se verifica la conexión
    return const Scaffold(
      backgroundColor: AppColors.fondo,
      body: LoadingAnimation(mensaje: "Cargando..."),
    );
  }
}
