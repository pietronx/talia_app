import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talia_app/models/news_model.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_news.dart';
import '../widgets/widgets_util.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final String csvUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vQTiA2kOPEniW9CkTSUEBE_a9Z51PxqU_KC6K7EuH7uvfZ0FPkvpJIYJGGFa0oRbHExIwj2SyLPYRcc/pub?output=csv';

  late Future<List<Noticia>> _Noticia;

  Future<List<Noticia>> cargarNoticias() async {
    final response = await http.get(Uri.parse(csvUrl));

    if (response.statusCode != 200) {
      if (kDebugMode) {
        print('❌ Error al cargar el CSV. Código: ${response.statusCode}');
      }
      throw Exception('Error al cargar el CSV');
    }

    final contenido = utf8.decode(response.bodyBytes);
    final columnas = const CsvToListConverter().convert(contenido, eol: '\n');

    List<Noticia> noticias = [];

    if (kDebugMode) {
      print('📄 Total de columnas: ${columnas.length}');
    }
    for (int i = 1; i < columnas.length; i++) {
      final columna = columnas[i];
      if (kDebugMode) {
        print('➡️ Columna $i: $columna');
      }

      if (columna.length < 6) {
        if (kDebugMode) {
          print('⚠️ columna $i ignorada (faltan filas)');
        }
        continue;
      }

      final activo = columna[5].toString().trim().toLowerCase().startsWith('s');
      if (kDebugMode) {
        print('🟡 Activo: $activo');
      }

      if (!activo) {
        if (kDebugMode) {
          print('🚫 Columna $i no está activa');
        }
        continue;
      }

      final noticia = Noticia(
        titulo: columna[0].toString(),
        fecha: columna[1].toString(),
        descripcion: columna[2].toString(),
        portadaUrl: columna[3].toString(),
        linkMasInfo:
            columna[4].toString().isEmpty ? null : columna[4].toString(),
        activo: columna[5].toString().trim().toLowerCase() == 'sí',
      );

      if (kDebugMode) {
        print('✅ Noticia cargada: ${noticia.titulo}');
      }
      noticias.add(noticia);
    }

    if (kDebugMode) {
      print('🎯 Noticias activas totales: ${noticias.length}');
    }
    return noticias;
  }

  @override
  void initState() {
    super.initState();
    _Noticia = cargarNoticias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Noticia>>(
        future: _Noticia,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final noticias = snapshot.data!;
          final activos = noticias.where((e) => e.activo).toList();

          if (activos.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 80, color: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      "No hay noticias disponibles.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Noticias',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: Colors.black54,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/bannerNoticias.jpg',
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
                actions: [
                  IconButton(
                    icon: const Icon(Icons.help),
                    color: AppColors.appbarIcons,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HelpNews()),
                      );
                    },
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final noticia = activos[index];
                      return WidgetsUtil.tarjetaNoticia(
                        context: context,
                        index: index,
                        noticia: noticia,
                      );
                    },
                    childCount: activos.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
