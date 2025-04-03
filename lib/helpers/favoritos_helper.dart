import 'package:hive/hive.dart';
import '../models/concierto_model.dart';

class FavoritosHelper {
  static Box<Concierto> get _box => Hive.box<Concierto>('favoritos');

  /// Obtener todos los conciertos favoritos
  static List<Concierto> getFavoritos() => _box.values.toList();

  /// Verifica si un concierto ya está marcado como favorito
  static bool esFavorito(Concierto c) {
    return _box.values.any(
          (f) => f.nombre == c.nombre && f.fecha == c.fecha,
    );
  }

  /// Añadir o eliminar de favoritos (toggle)
  static void toggleFavorito(Concierto concierto) {
    final yaEsFavorito = esFavorito(concierto);
    if (yaEsFavorito) {
      // Encuentra la clave y elimina
      final key = _box.keys.firstWhere((k) {
        final fav = _box.get(k);
        return fav?.nombre == concierto.nombre && fav?.fecha == concierto.fecha;
      });
      _box.delete(key);
    } else {
      _box.add(concierto);
    }
  }
}