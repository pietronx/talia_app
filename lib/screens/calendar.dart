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
import 'about_us.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
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
      drawer: DrawerUtil.appDrawer(context, currentRoute: 'calendar'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            WidgetsUtil.contenedorPersonalizado(
              text: '"Leyenda explicativa del calendario"',
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              color: AppColors.drawerCabecera,
              thickness: 1,
            ),
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
                                fontSize: 18,
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
                      const SizedBox(height: 8),
                      Text('🕒 ${conciertoSeleccionado!.hora}'),
                      Text('📍 ${conciertoSeleccionado!.lugar}'),
                      if (conciertoSeleccionado!.notas.isNotEmpty)
                        Text('📝 ${conciertoSeleccionado!.notas}'),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 25),
            Divider(
              indent: 10,
              endIndent: 10,
              color: AppColors.drawerCabecera,
              thickness: 1,
            ),
            WidgetsUtil.contenedorPersonalizado(
              text: '"Eventos disponibles de la web"',
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              color: AppColors.drawerCabecera,
              thickness: 1,
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutUs()),
                );
              },
              icon: const Icon(Icons.add_business),
              label: const Text('Ver mis Eventos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appbar,
                foregroundColor: AppColors.appbarTitulo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            WidgetsUtil.pieDePagina(),
          ],
        ),
      ),
    );
  }
}
