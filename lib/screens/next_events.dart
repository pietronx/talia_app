// Librerías necesarias para carga remota, parsing CSV y UI
import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talia_app/models/next_events_model.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_next_events.dart';
import '../widgets/banner.dart';
import '../widgets/loading_animation.dart';
import '../widgets/widgets_util.dart';

// Pantalla que muestra los próximos eventos
class NextEvents extends StatefulWidget {
  const NextEvents({super.key});

  @override
  State<NextEvents> createState() => _NextEventsState();
}

class _NextEventsState extends State<NextEvents> {
  // URL de Google Sheets en formato CSV
  final String csvUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vR2YQtyNcsOlsksWWq4bdIuzXZ_7iS7TyiPDOL_1a_miRgKc2gIJM1nopedVdjE9cmc4T5H5SY4C63D/pub?output=csv';

  late Future<List<ProximoEvento>> _futureEventos;

  @override
  void initState() {
    super.initState();
    _futureEventos = cargarEventosProximos();
  }

  // Carga de eventos desde el CSV remoto
  Future<List<ProximoEvento>> cargarEventosProximos() async {
    try {
      final response = await http.get(Uri.parse(csvUrl));

      // Si la solicitud falla (sin conexión)
      if (response.statusCode != 200) {
        throw Exception("Error en respuesta HTTP: ${response.statusCode}");
      }

      final contenido = utf8.decode(response.bodyBytes);
      final columnas = const CsvToListConverter().convert(contenido, eol: '\n');

      List<ProximoEvento> eventos = [];

      for (int i = 1; i < columnas.length; i++) {
        final columna = columnas[i];
        if (columna.length < 9) continue;

        final activo = columna[8].toString().trim().toLowerCase().startsWith('s');
        if (!activo) continue;

        eventos.add(
          ProximoEvento(
            titulo: columna[0].toString(),
            subtitulo: columna[1].toString(),
            descripcion: columna[2].toString(),
            fecha: columna[3].toString(),
            lugar: columna[4].toString(),
            portadaUrl: columna[5].toString(),
            linkEntradas: columna[6].toString().isEmpty ? null : columna[6].toString(),
            linkMasInfo: columna[7].toString().isEmpty ? null : columna[7].toString(),
            activo: true,
          ),
        );
      }

      return eventos;
    } catch (e) {
      debugPrint('Error al cargar los eventos: $e');

      // Si es un error de conexión
      if (e.toString().contains("Failed host lookup")) {
        throw Exception("Sin conexión a Internet");
      }

      return []; // Si otro tipo de error ocurre, devuelve lista vacía
    }
  }

  @override
  Widget build(BuildContext context) {
    // Variables responsivas
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.08;
    final verticalPadding = screenHeight * 0.02;
    final fontSize = screenWidth * 0.05;

    return Scaffold(
      body: FutureBuilder<List<ProximoEvento>>(
        future: _futureEventos,
        builder: (context, snapshot) {
          // Estado de carga
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingAnimation(
              mensaje: "Cargando próximos eventos...",
            );
          }

          // Manejo de error o datos nulos
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
                      "No se pudo cargar los eventos.\nRevisa tu conexión a Internet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSize),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futureEventos = cargarEventosProximos();
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

          final eventos = snapshot.data!;
          final activos = eventos.where((e) => e.activo).toList();

          // Caso: no hay eventos activos
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
                      "No hay próximos eventos disponibles.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                ),
              ),
            );
          }

          // Renderizado de eventos
          return CustomScrollView(
            slivers: [
              // Banner de sección con botón de ayuda
              BannerPersonalizado(
                titulo: 'Próximos Eventos',
                fontSize: screenWidth * 0.05,
                assetImage: 'assets/images/bannerProximosEventos.jpg',
                acciones: [
                  IconButton(
                    icon: const Icon(Icons.help),
                    color: AppColors.appbarIcons,
                    onPressed: () {
                      try {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HelpNextEvents(),
                          ),
                        );
                      } catch (e) {
                        debugPrint('Error al navegar a HelpNextEvents: $e');
                      }
                    },
                  ),
                ],
              ),

              // Lista de eventos activos renderizados como tarjetas
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: horizontalPadding,
                ),
                sliver: SliverToBoxAdapter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // Tarjetas apiladas verticalmente
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 1,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: activos.length,
                    itemBuilder: (context, index) {
                      final evento = activos[index];
                      return WidgetsUtil.tarjetaProximoEvento(
                        context: context,
                        index: index,
                        evento: evento,
                      );
                    },
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
