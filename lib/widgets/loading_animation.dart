import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../customColors/app_colors.dart';

class LoadingAnimation extends StatelessWidget {
  final String mensaje;

  const LoadingAnimation({super.key, this.mensaje = 'Cargando...'});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/loading.json',
            width: screenWidth * 0.5,
            height: screenWidth * 0.5,
            repeat: true,
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            mensaje,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              color: AppColors.appbar,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
