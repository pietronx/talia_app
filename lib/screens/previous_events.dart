import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talia_app/widgets/loading_animation.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_previous_events.dart';
import '../models/previous_events_model.dart';
import '../widgets/banner.dart';
import '../widgets/widgets_util.dart';

class PreviousEvents extends StatefulWidget {
  const PreviousEvents({super.key});

  @override
  State<PreviousEvents> createState() => _PreviousEventsState();
}

class _PreviousEventsState extends State<PreviousEvents> {
  final String csvUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vQpj5i8wyfi_5Iyb2KNhVQsL7k2EMICxVhs2cjNTEbJN5PMXObKcGqvI1jaEOOqqA2qbv10IP7P6VYE/pub?output=csv';

  late Future<List<AnteriorEvento>> _futureEventos;

  Future<List<AnteriorEvento>> cargarEventos() async {
    final response = await http.get(Uri.parse(csvUrl));

    if (response.statusCode == 200) {
      List<AnteriorEvento> eventos = [];
      final String contenido = utf8.decode(response.bodyBytes);
      final List<List<dynamic>> filas = const CsvToListConverter().convert(
        contenido,
        eol: '\n',
      );

      for (int i = 1; i < filas.length; i++) {
        List<dynamic> columnas = filas[i];
        if (columnas.length >= 6) {
          eventos.add(
            AnteriorEvento(
              titulo: columnas[0].toString(),
              subtitulo: columnas[1].toString(),
              descripcion: columnas[2].toString(),
              imagenUrl: columnas[3].toString(),
              programaUrl: columnas[4].toString().isNotEmpty ? columnas[4].toString() : null,
              activo: columnas[5].toString().trim().toLowerCase() == 'sí',
            ),
          );
        }
      }
      return eventos;
    } else {
      throw Exception('Error cargando los eventos');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureEventos = cargarEventos();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.08;
    final verticalPadding = screenHeight * 0.05;
    final contentMaxWidth = 600.0;

    return Scaffold(
      body: FutureBuilder<List<AnteriorEvento>>(
        future: _futureEventos,
        builder: (context, snapshot) {
          final iconSize = screenWidth * 0.2;
          final fontSize = screenWidth * 0.05;
          final padding = screenWidth * 0.1;

          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingAnimation(mensaje: "Cargando anteriores eventos...");
          }

          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: iconSize, color: Colors.redAccent),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "No se pudo cargar los eventos.\nRevisa tu conexión a Internet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSize),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futureEventos = cargarEventos();
                        });
                      },
                      child: Text("Reintentar", style: TextStyle(fontSize: fontSize * 0.9)),
                    ),
                  ],
                ),
              ),
            );
          }

          final eventos = snapshot.data!;
          final eventosActivos = eventos.where((e) => e.activo).toList();

          if (eventosActivos.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: iconSize, color: Colors.grey),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "No hay eventos disponibles en este momento.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              BannerPersonalizado(
                titulo: 'Anteriores Eventos',
                fontSize: screenWidth * 0.05,
                assetImage: 'assets/images/bannerEventosRecordar.jpg',
                acciones: [
                  IconButton(
                    icon: const Icon(Icons.help),
                    color: AppColors.appbarIcons,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HelpPreviousEvents()),
                      );
                    },
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final evento = eventosActivos[index];
                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: contentMaxWidth),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * 0.08),
                            child: WidgetsUtil.tarjetaAnteriorEvento(
                              context: context,
                              titulo: evento.titulo,
                              subtitulo: evento.subtitulo,
                              imagenUrl: evento.imagenUrl,
                              descripcion: evento.descripcion,
                              programaUrl: evento.programaUrl,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: eventosActivos.length,
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