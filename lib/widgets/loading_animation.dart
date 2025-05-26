import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../customColors/app_colors.dart';

// Widget reutilizable para mostrar una animación de carga con un mensaje opcional
class LoadingAnimation extends StatelessWidget {
  final String mensaje; // Texto mostrado debajo de la animación

  const LoadingAnimation({super.key, this.mensaje = 'Cargando...'});

  @override
  Widget build(BuildContext context) {
    // Dimensiones responsivas según tamaño de pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente el contenido
        children: [
          // Animación Lottie de una guitarra (se repite indefinidamente)
          Lottie.asset(
            'assets/animations/loading_guitar.json',
            width: screenWidth * 0.5,
            height: screenWidth * 0.5,
            repeat: true,
          ),

          SizedBox(height: screenHeight * 0.02),

          // Texto descriptivo debajo de la animación
          Text(
            mensaje,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              color: AppColors.appbar, // Se usa color principal de la app
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}