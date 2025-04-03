import 'package:hive/hive.dart';

part 'concierto_model.g.dart'; // Se generará automáticamente

@HiveType(typeId: 0)
class Concierto extends HiveObject {
  @HiveField(0)
  final String nombre;

  @HiveField(1)
  final DateTime fecha;

  @HiveField(2)
  final String hora;

  @HiveField(3)
  final String lugar;

  @HiveField(4)
  final String notas;

  Concierto({
    required this.nombre,
    required this.fecha,
    required this.hora,
    required this.lugar,
    required this.notas,
  });

  factory Concierto.fromCsv(List<String> campos) {
    return Concierto(
      nombre: campos[0],
      fecha: DateTime.parse(campos[1]),
      hora: campos[2],
      lugar: campos[3],
      notas: campos[4],
    );
  }
}
