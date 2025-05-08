import 'package:flutter/material.dart';

class BannerPersonalizado extends StatelessWidget {
  final String titulo;
  final String assetImage;
  final double? fontSize;
  final List<Widget>? acciones;

  const BannerPersonalizado({
    super.key,
    required this.titulo,
    required this.assetImage,
    this.fontSize,
    this.acciones,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      actions: acciones,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          titulo,
          style: TextStyle(
            fontSize: fontSize ?? 20, // valor por defecto si no se especifica
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(
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
            Image.asset(
              assetImage,
              fit: BoxFit.cover,
            ),
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