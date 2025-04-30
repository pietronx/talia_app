import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../customColors/app_colors.dart';
import '../helpScreens/help_previous_events.dart';
import '../models/previous_events_model.dart';
import '../widgets/widgets_util.dart';

class PreviousEvents extends StatefulWidget {
  const PreviousEvents({super.key});

  @override
  State<PreviousEvents> createState() => _PreviousEventsState();
}

class _PreviousEventsState extends State<PreviousEvents> {
  final String csvUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vRGhsvCt--uop_uX5RkZr3JtyRf75NfA1VyOgkynkcETzZsvb_QT6fhMv15lMVfuPx6XBog31KsSzIJ/pub?output=csv';

  // Variables para almacenar los eventos
  late Future<List<AnteriorEvento>> _futureEventos;

  // Función para cargar los eventos desde el archivo CSV
  Future<List<AnteriorEvento>> cargarEventos() async {
    final response = await http.get(Uri.parse(csvUrl));

    if (response.statusCode == 200) {
      List<AnteriorEvento> eventos = [];

      // Aquí está la diferencia importante:
      final String contenido = utf8.decode(response.bodyBytes);

      final List<List<dynamic>> filas = const CsvToListConverter().convert(
        contenido,
        eol: '\n',
      );

      for (int i = 1; i < filas.length; i++) {
        // Saltar cabecera
        List<dynamic> columnas = filas[i];
        if (columnas.length >= 6) {
          eventos.add(
            AnteriorEvento(
              titulo: columnas[0].toString(),
              subtitulo: columnas[1].toString(),
              descripcion: columnas[2].toString(),
              imagenUrl: columnas[3].toString(),
              programaUrl:
                  columnas[4].toString().isNotEmpty
                      ? columnas[4].toString()
                      : null,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eventos para Recordar"),
        actions: [
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
      body: FutureBuilder<List<AnteriorEvento>>(
        future: _futureEventos,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "No se pudo cargar los eventos.\nPor favor, revisa tu conexión a Internet o inténtalo más tarde.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futureEventos = cargarEventos();
                        });
                      },
                      child: const Text("Reintentar"),
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.event_busy, size: 80, color: Colors.grey),
                    const SizedBox(height: 20),
                    const Text(
                      "No hay eventos disponibles en este momento.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          }

          // Mostrar los eventos
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // Grid de eventos
                GridView.builder(
                  shrinkWrap: true, // importante para que no tome scroll infinito
                  physics: const NeverScrollableScrollPhysics(), // usa el scroll de fuera
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: eventosActivos.length,
                  itemBuilder: (context, index) {
                    final evento = eventosActivos[index];
                    return WidgetsUtil.tarjetaAnteriorEvento(
                      context: context,
                      titulo: evento.titulo,
                      subtitulo: evento.subtitulo,
                      imagenUrl: evento.imagenUrl,
                      descripcion: evento.descripcion,
                      programaUrl: evento.programaUrl,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}