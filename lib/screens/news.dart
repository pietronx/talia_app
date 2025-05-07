import 'package:flutter/material.dart';
import 'package:talia_app/helpScreens/help_news.dart';

import '../customColors/app_colors.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            color: AppColors.appbarIcons,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpNews()),
              );
            },
          ),
        ],
      ),
    );
  }
}
