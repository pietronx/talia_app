
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talia_app/customColors/app_colors.dart';
import 'package:talia_app/widgets/loading_animation.dart';

import 'home_screen.dart';
import 'no_connection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    inicializarApp();
  }

// ignore_for_file: avoid_print, use_build_context_synchronously
  Future<void> inicializarApp() async {
    print("Inicializando...");

    await Future.delayed(const Duration(seconds: 2));
    print("Pasado delay");

    final conectado = await comprobarConexion();
    print("¿Hay conexión? $conectado");

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
  }

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

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: AppColors.fondo,
      body: LoadingAnimation(mensaje: "Cargando..."),
    );
  }
}