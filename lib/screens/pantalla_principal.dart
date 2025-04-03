import 'package:flutter/material.dart';
import '../helpScreens/help_screen.dart';
import '../widgets/widgets_util.dart';
import '../customColors/app_colors.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: const TextStyle(color: AppColors.appbarTitulo),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help),
            color: AppColors.appbarIcons,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpScreen()),
              );
            },
          ),
        ],
      ),
      drawer: DrawerUtil.appDrawer(context, currentRoute: 'home'),
      body: const Center(child: Text('Bienvenido a la aplicación')),
    );
  }
}