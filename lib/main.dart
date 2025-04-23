// Flutter SDK
import 'package:flutter/material.dart';

// Paquetes externos
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

// Clases
import 'package:talia_app/screens/about_us.dart';
import 'package:talia_app/screens/contact.dart';
import 'package:talia_app/screens/events.dart';
import 'package:talia_app/screens/next_events.dart';
import 'package:talia_app/screens/previous_events.dart';

// Archivos internos del proyecto
import 'customColors/app_colors.dart';
import 'helpScreens/help_screen.dart';
import 'models/concierto_model.dart';
import 'screens/home_screen.dart';

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
          toolbarHeight: 60,
          titleTextStyle: TextStyle(
            color: AppColors.appbarTitulo,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomeScreen(titulo: 'Inicio'),
      routes: {
        '/about_us': (context) => const AboutUs(),
        '/contact': (context) => const Contact(),
        '/screens/events': (context) => const Events(),
        '/screens/nextEvents': (context) => const NextEvents(),
        '/helpScreens/help_screen': (context) => const HelpScreen(),
        '/screens/previousEvents': (context) => const PreviousEvents(),
      },
    );
  }
}
