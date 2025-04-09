import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_calendar.dart';
import '../helpers/favoritos_helper.dart';
import '../models/concierto_model.dart';
import '../widgets/widgets_util.dart';

class NextEvents extends StatefulWidget {
  const NextEvents({super.key});

  @override
  State<NextEvents> createState() => _CalendarState();
}

class _CalendarState extends State<NextEvents> {
  final String csvUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vRq83A-klFY_t9iZkUpwc97yyuRN_mpMUEI8DTj_Q88nodQZVXU8nEGrrm_59zKWCXHEUaVDyHDEE72/pub?gid=0&single=true&output=csv';

  List<Concierto> conciertos = [];
  Set<DateTime> fechasConciertos = {};
  DateTime? selectedDay;
  Concierto? conciertoSeleccionado;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES');
    cargarCSV();
  }

  Future<void> cargarCSV() async {
    try {
      final response = await http.get(Uri.parse(csvUrl));
      if (response.statusCode == 200) {
        final csvContent = utf8.decode(response.bodyBytes);
        final rows = const LineSplitter().convert(csvContent);
        final data = rows.skip(1).map((line) => line.split(',')).toList();
        final parsed = data.map((campos) => Concierto.fromCsv(campos)).toList();

        setState(() {
          conciertos = parsed;
          fechasConciertos =
              parsed
                  .map(
                    (c) => DateTime(c.fecha.year, c.fecha.month, c.fecha.day),
                  )
                  .toSet();
        });
      }
    } catch (e) {
      debugPrint('Error al cargar CSV: \$e');
    }
  }

  bool _esConcierto(DateTime day) {
    final fecha = DateTime(day.year, day.month, day.day);
    return fechasConciertos.contains(fecha);
  }

  Widget _colorMuestra(Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help),
            color: AppColors.appbarIcons,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpCalendar()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetsUtil.contenedorPersonalizado(
              text: 'Próximos Eventos',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textoColor: AppColors.titulo,
            ),
            Divider(
              height: 0.1,
              indent: 10,
              endIndent: 10,
              thickness: 2,
              color: AppColors.drawerCabecera,
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft, //--> Leyenda
              child: const Text(
                'Leyenda del Calendario',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titulo,
                ),
              ),
            ),

            const SizedBox(height: 10),
            // Dia de Hoy
            Row(
              children: [
                _colorMuestra(AppColors.diaActual),
                const SizedBox(width: 8),
                const Text(
                  'Hoy',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 6),
            // Dia de seleccionado
            Row(
              children: [
                _colorMuestra(AppColors.diaSeleccionado),
                const SizedBox(width: 8),
                const Text(
                  'Día seleccionado',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 6),
            // Dia de concierto
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.diaConcierto,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.diaConciertoTexto,
                      width: 2,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Día con concierto',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Divider(
              indent: 10,
              endIndent: 10,
              color: AppColors.drawerCabecera,
              thickness: 1,
            ),

            // Calendario
            TableCalendar(
              locale: 'es_ES',
              focusedDay: selectedDay ?? DateTime.now(),
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              selectedDayPredicate: (day) => isSameDay(day, selectedDay),
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              weekendDays: const [DateTime.saturday, DateTime.sunday],
              calendarStyle: CalendarStyle(
                weekendTextStyle: const TextStyle(color: Colors.red),
                todayDecoration: BoxDecoration(
                  color: AppColors.diaActual,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppColors.diaSeleccionado,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, _) {
                  if (_esConcierto(date)) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.diaConcierto,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.diaConciertoTexto,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.diaConciertoTexto,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDay = selected;
                  conciertoSeleccionado = conciertos.firstWhere(
                    (c) => isSameDay(c.fecha, selected),
                    orElse:
                        () => Concierto(
                          nombre: 'Sin eventos',
                          fecha: selected,
                          hora: '',
                          lugar: '',
                          notas: '',
                        ),
                  );
                });
              },
            ),

            const SizedBox(height: 20),

            // Detalle del concierto seleccionado
            if (conciertoSeleccionado != null &&
                conciertoSeleccionado!.nombre != 'Sin eventos')
              Card(
                color: AppColors.contenedor,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conciertoSeleccionado!.nombre,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              FavoritosHelper.esFavorito(conciertoSeleccionado!)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                FavoritosHelper.toggleFavorito(
                                  conciertoSeleccionado!,
                                );
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '🕒 ${conciertoSeleccionado!.hora}',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '📍 ${conciertoSeleccionado!.lugar}',
                        style: TextStyle(fontSize: 15),
                      ),
                      if (conciertoSeleccionado!.notas.isNotEmpty)
                        Text(
                          '📝 ${conciertoSeleccionado!.notas}',
                          style: TextStyle(fontSize: 15),
                        ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 5),

            // Boton de favoritos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Favoritos
                ElevatedButton.icon(
                  onPressed: () {
                    List<Concierto> favoritos =
                        FavoritosHelper.getFavoritos()
                          ..sort((a, b) => a.fecha.compareTo(b.fecha));
                    // Bottom sheet (lista de favoritos)
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      builder: (_) {
                        return StatefulBuilder(
                          builder: (context, setStateSheet) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 20,
                                bottom: 40,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Favoritos',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  Flexible(
                                    child:
                                        favoritos.isEmpty
                                            ? const Center(
                                              child: Text(
                                                'Aún no has añadido favoritos.',
                                              ),
                                            )
                                            : ListView.builder(
                                              itemCount: favoritos.length,
                                              itemBuilder: (_, index) {
                                                final concierto =
                                                    favoritos[index];
                                                return ListTile(
                                                  leading: IconButton(
                                                    icon: const Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      FavoritosHelper.toggleFavorito(
                                                        concierto,
                                                      );
                                                      setStateSheet(() {
                                                        favoritos =
                                                            FavoritosHelper.getFavoritos();
                                                      });
                                                    },
                                                  ),
                                                  title: Text(concierto.nombre),
                                                  subtitle: Text(
                                                    '${concierto.fecha.day}/${concierto.fecha.month} - ${concierto.lugar}',
                                                  ),
                                                );
                                              },
                                            ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.favorite),
                  label: const Text('Favoritos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.diaSeleccionado,
                    foregroundColor: AppColors.appbarTitulo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),

            // Copyright y Legal
            WidgetsUtil.pieDePagina(),

          ],
        ),
      ),
    );
  }
}
