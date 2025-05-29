// Flutter SDK
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Paquetes externos
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:talia_app/helpScreens/help_offline.dart';

// Clases
import 'package:talia_app/screens/about_us.dart';
import 'package:talia_app/screens/contact.dart';
import 'package:talia_app/screens/events.dart';
import 'package:talia_app/screens/news.dart';
import 'package:talia_app/screens/next_events.dart';
import 'package:talia_app/screens/previous_events.dart';
import 'package:talia_app/screens/splash_screen.dart';
import 'package:talia_app/screens/abonados.dart';

// Archivos internos del proyecto
import 'customColors/app_colors.dart';
import 'helpScreens/help_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es_ES', null);
  await Hive.initFlutter();

  // Solo permitir orientación vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

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
      home: const SplashScreen(),
      // Definir rutas para las pantallas
      routes: {
        '/screens/home_screen': (context) => const HomeScreen(titulo: 'Inicio'),
        '/about_us': (context) => const AboutUs(),
        '/contact': (context) => const Contact(),
        '/screens/events': (context) => const Events(),
        '/screens/nextEvents': (context) => const NextEvents(),
        '/screens/previousEvents': (context) => const PreviousEvents(),
        '/screens/news': (context) => const News(),
        '/screens/susbcribers': (context) => const Abonados(),
        '/helpScreens/help_screen': (context) => const HelpScreen(),
        '/helpScreens/help_offline': (context) => const HelpOffline(),
        '/splash_screen': (context) => const SplashScreen(),
      },
    );
  }
}
