import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_about_us.dart';
import '../widgets/widgets_util.dart';

class OfflineAboutUs extends StatelessWidget {
  const OfflineAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;
    final tituloFontSize = screenWidth * 0.08;
    final espacioGrande = screenHeight * 0.04;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nosotros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            color: AppColors.appbarIcons,
            onPressed: () {
              try {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpAboutUs()),
                );
              } catch (e) {
                debugPrint('Error al navegar a HelpAboutUs: $e');
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 20,
        ),
        child: Column(
          children: [
            SizedBox(height: espacioGrande),
            Column(
              children: [
                WidgetsUtil.contenedorPersonalizado(
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.15,
                  path: 'assets/images/bannerGrupoTalia.png',
                  fit: BoxFit.contain,
                ),
                SizedBox(height: espacioGrande * 1.1),
                // Mensaje de bienvenida
                Text(
                  '¡Bienvenido a la App\ndel Grupo Talía!',
                  style: TextStyle(
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.bold,
                    color: AppColors.texto,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: espacioGrande),
            WidgetsUtil.contenedorPersonalizado(
              text: 'Directores',
              fontSize: tituloFontSize,
              fontWeight: FontWeight.bold,
              textoColor: AppColors.titulo,
            ),
            Divider(
              height: 0.1,
              indent: screenWidth * 0.2,
              endIndent: screenWidth * 0.2,
              color: AppColors.dividerColor,
              thickness: 2,
            ),
            SizedBox(height: espacioGrande),

            // Card scrollable de Silvia Sanz
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: AppColors.cardSilvia,
              child: Container(
                width: screenWidth * 0.85,
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.2,
                      backgroundImage: AssetImage(
                        'assets/images/silviaimg.png',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'SILVIA SANZ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: AppColors.fondo,
                      ),
                    ),
                    Text(
                      '"DIRECTORA TITULAR"',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontStyle: FontStyle.italic,
                        color: AppColors.fondo,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      height: screenHeight * 0.4,
                      // Área de scroll dentro de la tarjeta
                      child: SingleChildScrollView(
                        child: Text(
                          'Nacida en Madrid, realizó sus estudios musicales en el '
                          'Conservatorio Superior de Música donde estudió '
                          'Dirección de Orquesta con Enrique García Asensio, '
                          'completando su formación con destacados maestros.\n\n '
                          'Fue directora asistente en la Orquesta y Coro Nacionales de España '
                          'durante la temporada 1993/1994.\n\n'
                          'Es fundadora y directora titular del Grupo Talía y todas sus formaciones musicales: '
                          '\n\nOrquesta Metropolitana de Madrid, Coro Talía, Youth Orchestra, Orquesta Infantil Jonsui '
                          'y Coro Talía Mini.\n\n'
                          'Ha dirigido más de 200 conciertos en el Auditorio Nacional de Música, '
                          'así como en diversos países de Europa, América, África y Asia.',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            color: AppColors.fondo,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.08),
            // Card scrollable de Alejandro Vivas
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: AppColors.cardAlejandro,
              child: Container(
                width: screenWidth * 0.85,
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.2,
                      backgroundImage: AssetImage(
                        'assets/images/alejandroimg.png',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'ALEJANDRO VIVAS',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: AppColors.fondo,
                      ),
                    ),
                    Text(
                      '"DIRECTOR ARTÍSTICO"',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontStyle: FontStyle.italic,
                        color: AppColors.fondo,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      height: screenHeight * 0.4,
                      //Área de scroll dentro de la tarjeta
                      child: SingleChildScrollView(
                        child: Text(
                          'Alejandro Vivas es un músico, compositor y arreglista nacido en Almería, '
                          'con formación en guitarra, contrapunto, fuga y armonía en Madrid.\n\n'
                          'Es miembro de la Real Academia de las Artes y las Ciencias Cinematográficas de España, '
                          'y con más de 20 años de trayectoria, ha trabajado en composición, '
                          'orquestación, producción musical y dirección artística, '
                          'además de desarrollar proyectos pedagógicos y docencia en música. '
                          'Su obra abarca desde música instrumental y coral hasta géneros modernos como el jazz, '
                          'soul y pop.\n\nHa compuesto bandas sonoras destacadas, '
                          'como: La conjura de El Escorial (2008) y El jugador de ajedrez (2017), '
                          'recibiendo reconocimiento nacional e internacional.',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            color: AppColors.fondo,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            WidgetsUtil.pieDePagina(context),
          ],
        ),
      ),
    );
  }
}
