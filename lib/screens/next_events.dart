import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talia_app/models/next_events_model.dart';

import '../widgets/widgets_util.dart';

class NextEvents extends StatefulWidget {
  const NextEvents({super.key});

  @override
  State<NextEvents> createState() => _NextEventsState();
}

class _NextEventsState extends State<NextEvents> {
  final String csvUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vStDcPA-zY1JFnVRKGE8GaUcIDSPHAYcu8NZrmfDBsMJCOS452wNU5MSeIckU__xctVpYC0eUPO_Vwz/pub?output=csv';
  late Future<List<ProximoEvento>> _futureEventos;

  Future<List<ProximoEvento>> cargarEventosProximos() async {
    final response = await http.get(Uri.parse(csvUrl));

    if (response.statusCode != 200) {
      if (kDebugMode) {
        print('❌ Error al cargar el CSV. Código: ${response.statusCode}');
      }
      throw Exception('Error al cargar el CSV');
    }

    final contenido = utf8.decode(response.bodyBytes);
    final columnas = const CsvToListConverter().convert(contenido, eol: '\n');

    List<ProximoEvento> eventos = [];

    if (kDebugMode) {
      print('📄 Total de columnas: ${columnas.length}');
    }
    for (int i = 1; i < columnas.length; i++) {
      final columna = columnas[i];
      if (kDebugMode) {
        print('➡️ Columna $i: $columna');
      }

      if (columna.length < 9) {
        if (kDebugMode) {
          print('⚠️ columna $i ignorada (faltan filas)');
        }
        continue;
      }

      final activo = columna[8].toString().trim().toLowerCase().startsWith('s');
      if (kDebugMode) {
        print('🟡 Activo: $activo');
      }

      if (!activo) {
        if (kDebugMode) {
          print('🚫 Columna $i no está activa');
        }
        continue;
      }

      final evento = ProximoEvento(
        titulo: columna[0].toString(),
        subtitulo: columna[1].toString(),
        descripcion: columna[2].toString(),
        fecha: columna[3].toString(),
        lugar: columna[4].toString(),
        portadaUrl: columna[5].toString(),
        linkEntradas:
            columna[6].toString().isEmpty ? null : columna[6].toString(),
        linkMasInfo:
            columna[7].toString().isEmpty ? null : columna[7].toString(),
        activo: true,
      );

      if (kDebugMode) {
        print('✅ Evento cargado: ${evento.titulo}');
      }
      eventos.add(evento);
    }

    if (kDebugMode) {
      print('🎯 Eventos activos totales: ${eventos.length}');
    }
    return eventos;
  }

  @override
  void initState() {
    super.initState();
    _futureEventos = cargarEventosProximos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Próximos Eventos")),
      body: FutureBuilder<List<ProximoEvento>>(
        future: _futureEventos,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final eventos = snapshot.data!;
          final activos = eventos.where((e) => e.activo).toList();

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
                      "No hay próximos eventos disponibles.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
