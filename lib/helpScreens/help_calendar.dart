import 'package:flutter/material.dart';

class HelpCalendar extends StatelessWidget {
  const HelpCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda: Calendario')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            Text(
              '¿Qué puedes hacer en "Calendario"?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'En esta sección podrás visualizar los próximos eventos en los que participará el Grupo Talía.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'El calendario te permitirá consultar fechas clave de conciertos, actividades y eventos especiales.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Si ya adquiriste entradas, estos eventos también podrían aparecer destacados.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}