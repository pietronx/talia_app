import 'package:flutter/material.dart';
import 'package:talia_app/helpScreens/help_events.dart';

import '../customColors/app_colors.dart';
import '../widgets/widgets_util.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.08;
    final fontSize = screenWidth * 0.048;

    final items = [
      {
        'label': 'Anteriores\nEventos',
        'icon': 'assets/icons/pastEventsIcon.png',
        'route': '/screens/previousEvents',
      },
      {
        'label': 'Próximos\nEventos',
        'icon': 'assets/icons/futureEventsIcon.png',
        'route': '/screens/nextEvents',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpEvents()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 20,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return Column(
                  children: [
                    WidgetsUtil.gridMenu(
                      imagePath: item['icon']!,
                      onTap: () => Navigator.pushNamed(context, item['route']!),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      item['label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.texto,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
