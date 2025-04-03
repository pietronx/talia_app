// Flutter SDK
import 'package:flutter/material.dart';

// Paquetes externos
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

// Archivos internos del proyecto
import 'customColors/app_colors.dart';
import 'models/concierto_model.dart';
import 'screens/pantalla_principal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es_ES', null);

  await Hive.initFlutter();
  Hive.registerAdapter(ConciertoAdapter()); // ← necesario
  await Hive.openBox<Concierto>('favoritos'); // ← abre caja de favoritos

  runApp(const MyApp());
}

// Clase principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talia Group App',
      theme: ThemeData(
        primaryColor: AppColors.appbar,
        scaffoldBackgroundColor: AppColors.fondo,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.texto, fontSize: 16),
          bodyMedium: TextStyle(color: AppColors.texto, fontSize: 14),
          titleLarge: TextStyle(
            color: AppColors.titulo,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(color: AppColors.appbar, fontSize: 22),
        ),
        appBarTheme: const AppBarTheme(
          color: AppColors.appbar,
          iconTheme: IconThemeData(color: AppColors.appbarIcons),
          titleTextStyle: TextStyle(
            color: AppColors.appbarTitulo,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const PantallaPrincipal(titulo: 'Inicio'),
    );
  }
}
