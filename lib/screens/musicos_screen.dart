// Importaciones necesarias
import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talia_app/helpScreens/help_musician.dart';
import 'package:talia_app/widgets/loading_animation.dart';
import 'package:talia_app/widgets/musico_destacado.dart';

import '../customColors/app_colors.dart';
import '../models/musico.dart';
import '../widgets/banner.dart';

class Musicos extends StatefulWidget {
  const Musicos({super.key});

  @override
  State<Musicos> createState() => _MusicosScreenState();
}

class _MusicosScreenState extends State<Musicos> {
  // URL pública del CSV publicado en Google Sheets
  final String csvMusicosUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vQSSlMm4p1tacxduvnA6vG8lhKGGxr3YiYWwmuAoNmLXjOMQEXhdR25qfLcEgr0Kp6dMC8022MTguQl/pub?output=csv';

  late Future<List<Musico>> _musicosFuture;

  @override
  void initState() {
    super.initState();
    _musicosFuture = cargarMusicos();
  }

  // Función que carga y parsea el CSV de músicos
  Future<List<Musico>> cargarMusicos() async {
    try {
      final response = await http.get(Uri.parse(csvMusicosUrl));
      if (response.statusCode != 200) {
        throw Exception("Error en respuesta HTTP: ${response.statusCode}");
      }
      final contenido = utf8.decode(response.bodyBytes);
      final rows = const CsvToListConverter().convert(contenido, eol: '\n');

      List<Musico> musicos = [];

      for (int i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length < 5) continue;

        final activo = row[4].toString().trim().toLowerCase().startsWith('s');
        if (!activo) continue;

        musicos.add(
          Musico(
            nombre: row[0].toString(),
            instrumento: row[1].toString(),
            descripcion: row[2].toString(),
            fotoUrl: row[3].toString(),
            activo: true,
          ),
        );
      }
      return musicos;
    } catch (e) {
      throw Exception("Error al cargar músicos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Valores responsivos
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenWidth * 0.045;
    final horizontalPadding = screenWidth * 0.05;
    final verticalPadding = screenHeight * 0.05;

    return Scaffold(
      body: FutureBuilder<List<Musico>>(
        future: _musicosFuture,
        builder: (context, snapshot) {
          // Estado de carga: muestra la animación de carga general
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingAnimation(mensaje: "Cargando...");
          }

          // Gestión de errores o fallo de conexión
          if (snapshot.hasError || snapshot.data == null) {
            final iconSize = screenWidth * 0.2;
            final padding = screenWidth * 0.1;

            return Center(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: iconSize,
                      color: Colors.redAccent,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "No se pudo cargar el contenido.\nRevisa tu conexión a Internet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSize),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _musicosFuture = cargarMusicos();
                        });
                      },
                      child: Text(
                        "Reintentar",
                        style: TextStyle(fontSize: fontSize * 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final musicos = snapshot.data!;

          // Si no hay músicos disponibles
          if (musicos.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: screenWidth * 0.2,
                      color: Colors.grey,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "No hay integrantes disponibles.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                ),
              ),
            );
          }

          // Se muestran los músicos en un CustomScrollView que comienza con un banner
          return CustomScrollView(
            slivers: [
              BannerPersonalizado(
                titulo: 'Nuestro Equipo',
                fontSize: fontSize * 1.2,
                assetImage: 'assets/images/bannerIntegrantes.png',
                acciones: [
                  IconButton(
                    icon: const Icon(Icons.help),
                    color: AppColors.appbarIcons,
                    onPressed: () {
                      try {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HelpMusician()),
                        );
                      } catch (e) {
                        debugPrint('Error al navegar a HelpNews: $e');
                      }
                    },
                  ),
                ],
              ),

              // Título y descripción
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding * 1.5,
                    vertical: verticalPadding * 0.5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Conoce a los que integran el Grupo Talía...",
                        style: TextStyle(
                          fontSize: fontSize * 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: verticalPadding * 0.3),
                      Text(
                        "Descubre el talento y la pasión de algunos de los integrantes de nuestro equipo.",
                        style: TextStyle(fontSize: fontSize),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),

              // Lista de músicos
              SliverPadding(
                padding: EdgeInsets.only(
                  left: horizontalPadding * 0.5,
                  right: horizontalPadding * 0.5,
                  bottom: verticalPadding * 1.5,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final musico = musicos[index];
                    return MusicoDestacado(
                      nombre: musico.nombre,
                      instrumento: musico.instrumento,
                      descripcion: musico.descripcion,
                      fotoUrl: musico.fotoUrl,
                    );
                  }, childCount: musicos.length),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
