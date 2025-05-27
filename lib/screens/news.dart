// Librerías necesarias
import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talia_app/models/news_model.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_news.dart';
import '../widgets/banner.dart';
import '../widgets/loading_animation.dart';
import '../widgets/widgets_util.dart';

// Pantalla de noticias del
class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  // URL pública del CSV publicado desde Google Sheets
  final String csvUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vT_XFNr2J3C4AUMez56ZcFDosf5XkDz_yKKWrn0aHTZugLmX2Ig2_ahkviYmr_vRnTYnlp58diI38VA/pub?output=csv';

  late Future<List<Noticia>> _noticia;

  // Función para cargar y parsear las noticias desde el CSV remoto
  Future<List<Noticia>> cargarNoticias() async {
    try {
      final response = await http.get(Uri.parse(csvUrl));
      final contenido = utf8.decode(response.bodyBytes);
      final columnas = const CsvToListConverter().convert(contenido, eol: '\n');

      List<Noticia> noticias = [];

      for (int i = 1; i < columnas.length; i++) {
        final columna = columnas[i];
        if (columna.length < 6) continue;

        final activo = columna[5].toString().trim().toLowerCase().startsWith(
          's',
        );
        if (!activo) continue;

        final noticia = Noticia(
          titulo: columna[0].toString(),
          fecha: columna[1].toString(),
          descripcion: columna[2].toString(),
          portadaUrl: columna[3].toString(),
          linkMasInfo:
              columna[4].toString().isEmpty ? null : columna[4].toString(),
          activo: true,
        );

        noticias.add(noticia);
      }

      return noticias;
    } catch (e) {
      debugPrint('Error al cargar las noticias: $e');
      return []; // Si algo fall, devuelve la lista vacía
    }
  }

  @override
  void initState() {
    super.initState();
    _noticia = cargarNoticias(); // Se inicia la carga al arrancar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    // Valores responsivos
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.08;
    final verticalPadding = screenHeight * 0.05;
    final fontSize = screenWidth * 0.045;

    return Scaffold(
      body: FutureBuilder<List<Noticia>>(
        future: _noticia,
        builder: (context, snapshot) {
          // Pantalla de carga mientras se recuperan los datos
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingAnimation(mensaje: "Cargando noticias...");
          }

          // Manejo de errores o fallo de conexión
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
                      "No se pudo cargar las noticias.\nRevisa tu conexión a Internet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSize),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _noticia = cargarNoticias(); // Reintento manual
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

          final noticias = snapshot.data!;
          final activos = noticias.where((e) => e.activo).toList();

          // Si no hay noticias activas disponibles
          if (activos.isEmpty) {
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
                      "No hay noticias disponibles.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                ),
              ),
            );
          }

          // Renderizado de noticias activas en formato scroll + tarjetas
          return CustomScrollView(
            slivers: [
              // Banner de sección con botón de ayuda
              BannerPersonalizado(
                titulo: 'Noticias',
                fontSize: 20,
                assetImage: 'assets/images/bannerNoticias.jpg',
                acciones: [
                  IconButton(
                    icon: const Icon(Icons.help),
                    color: AppColors.appbarIcons,
                    onPressed: () {
                      try {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HelpNews()),
                        );
                      } catch (e) {
                        debugPrint('Error al navegar a HelpNews: $e');
                      }
                    },
                  ),
                ],
              ),

              // Lista de tarjetas de noticias
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final noticia = activos[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.025),
                      child: WidgetsUtil.tarjetaNoticia(
                        context: context,
                        index: index,
                        noticia: noticia,
                      ),
                    );
                  }, childCount: activos.length),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
