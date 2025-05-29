import 'package:flutter/material.dart';

class Abonados extends StatefulWidget {
  const Abonados({super.key});

  @override
  State<Abonados> createState() => _AbonadosState();
}

class _AbonadosState extends State<Abonados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Abonados')),
      body: const Center(
        child: Text(
          'Pantalla de abonados en construcción...',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
