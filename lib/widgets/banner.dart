import 'package:flutter/material.dart';

// Banner visual reutilizable con imagen de fondo, título y acciones opcionales
class BannerPersonalizado extends StatelessWidget {
  final String titulo;              // Título mostrado sobre el banner
  final String assetImage;         // Ruta de la imagen de fondo (asset)
  final double? fontSize;          // Tamaño del texto (opcional)
  final List<Widget>? acciones;    // Lista de acciones en la AppBar (opcional)

  const BannerPersonalizado({
    super.key,
    required this.titulo,
    required this.assetImage,
    this.fontSize,
    this.acciones,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SliverAppBar(
      expandedHeight: screenHeight * 0.3, // Altura expandida del banner
      pinned: true, // Hace que la barra se mantenga fija al hacer scroll
      actions: acciones, // Iconos de acción (ej: botón de ayuda)

      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          titulo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis, // Evita desbordamiento del texto
          style: TextStyle(
            fontSize: fontSize ?? screenWidth * 0.05,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow( // Sombra para mejorar contraste del título
                color: Colors.black87,
                offset: Offset(0, 1),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen de fondo que cubre todo el espacio
            Image.asset(
              assetImage,
              fit: BoxFit.cover,
            ),
            // Superposición de degradado para oscurecer el fondo por abajo
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}