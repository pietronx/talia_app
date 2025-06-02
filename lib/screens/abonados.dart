import 'package:flutter/material.dart';

import '../customColors/app_colors.dart';
import '../helpScreens/help_news.dart';
import '../widgets/banner.dart';
import '../widgets/widgets_util.dart';

class Abonados extends StatefulWidget {
  const Abonados({super.key});

  @override
  State<Abonados> createState() => _AbonadosState();
}

class _AbonadosState extends State<Abonados> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.08;
    final verticalPadding = screenHeight * 0.05;
    final fontSize = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: AppColors.fondo, // Fondo claro para evitar el negro
      body: CustomScrollView(
        slivers: [
          // Banner de sección con botón de ayuda
          BannerPersonalizado(
            titulo: 'Abonados',
            fontSize: titleFontSize,
            assetImage: 'assets/images/bannerAbonados.png',
            acciones: [
              IconButton(
                icon: const Icon(Icons.help),
                color: AppColors.appbarIcons,
                onPressed: () {
                  try {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HelpNews()),
                    );
                  } catch (e) {
                    debugPrint('Error al navegar a HelpNews: $e');
                  }
                },
              ),
            ],
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding * 1.4,
              vertical: verticalPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  // Título explicativo
                  Text(
                    '¿Qué son los abonos?',
                    style: TextStyle(
                      fontSize: titleFontSize * 1.1,
                      fontWeight: FontWeight.bold,
                      color: AppColors.titulo,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Divider(
                    color: AppColors.dividerColor,
                    thickness: 2,
                    height: screenHeight * 0.02,
                    indent: screenWidth * 0.05,
                    endIndent: screenWidth * 0.05,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Descripción de los abonos (manteniendo tu texto original)
                  Text(
                    'Los abonos te permiten disfrutar de toda la temporada musical '
                    'del Grupo Talía de forma cómoda y económica.\n\n'
                    'Asiste a los conciertos del Ciclo Sinfónico-Coral '
                    'con un precio reducido y reserva siempre el mismo asiento '
                    'para todas las funciones.\n\n'
                    'Una opción ideal para los amantes de la música '
                    'que buscan vivir una experiencia única durante toda la temporada. '
                    '¡Hazte abonado y déjate llevar por la magia de la música!',
                    style: TextStyle(
                      fontSize: fontSize * 0.9,
                      color: AppColors.texto,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: screenHeight * 0.07),

                  Text(
                    'Ventajas exclusivas\npara los Abonados',
                    style: TextStyle(
                      fontSize: titleFontSize * 1.1,
                      fontWeight: FontWeight.bold,
                      color: AppColors.titulo,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Divider(
                    color: AppColors.dividerColor,
                    thickness: 2,
                    height: screenHeight * 0.02,
                    indent: screenWidth * 0.06,
                    endIndent: screenWidth * 0.06,
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Beneficios en formato de tarjetas con iconos
                  Column(
                    children: [
                      _buildBenefitItem(
                        Icons.percent,
                        '25% de descuento',
                        'Sobre el precio de las entradas comprando el abono de 4 conciertos.',
                      ),
                      _buildBenefitItem(
                        Icons.chair,
                        'Venta preferente',
                        'Conserva siempre el mismo asiento para todas las funciones y temporadas.',
                      ),
                      _buildBenefitItem(
                        Icons.local_offer,
                        'Descuentos exclusivos',
                        '10% de descuento en entradas adicionales y conciertos extraordinarios.',
                      ),
                      _buildBenefitItem(
                        Icons.music_note,
                        'Talía Experience',
                        'Visita guiada al Auditorio Nacional de Música antes de un concierto.',
                      ),
                      _buildBenefitItem(
                        Icons.phone_android,
                        'Atención personalizada',
                        'Newsletter, comunicación vía WhatsApp y acceso al blog "El atril del Abonado".',
                      ),
                      _buildBenefitItem(
                        Icons.card_giftcard,
                        'Regalo de bienvenida',
                        'Un obsequio especial en el primer concierto de la temporada.',
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Botones de acción
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed:
                            () => OpenLink.abrirEnlace(
                              "https://grupotalia.koobin.com/?action=PU_abonados",
                            ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cardSilvia,
                          foregroundColor: AppColors.fondo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.015,
                            horizontal: screenWidth * 0.1,
                          ),
                        ),
                        child: Text(
                          "Comprar Abono",
                          style: TextStyle(
                            fontSize: fontSize * 0.8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      ElevatedButton(
                        onPressed:
                            () => OpenLink.abrirEnlace(
                              "https://grupotalia.koobin.com/es/zona-personal",
                            ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cardAlejandro,
                          foregroundColor: AppColors.fondo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.015,
                            horizontal: screenWidth * 0.1,
                          ),
                        ),
                        child: Text(
                          "Renovar Abono",
                          style: TextStyle(
                            fontSize: fontSize * 0.8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.07),

                      // Título de ayuda
                      Text(
                        '¿Necesitas ayuda para comprar tu abono?',
                        style: TextStyle(
                          fontSize: titleFontSize * 1.1,
                          fontWeight: FontWeight.bold,
                          color: AppColors.titulo,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      Divider(
                        color: AppColors.dividerColor,
                        thickness: 2,
                        height: screenHeight * 0.02,
                        indent: screenWidth * 0.06,
                        endIndent: screenWidth * 0.06,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Descripción con información de soporte
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: fontSize * 0.9,
                            color: AppColors.texto,
                          ),
                          children: [
                            TextSpan(text: 'Estamos en el teléfono '),
                            TextSpan(
                              text: '913185928',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: '.\n\nDe lunes a viernes de '),
                            TextSpan(
                              text: '8:00 a 13:30',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: '.\n\nTambién puedes escribir un mail a '),
                            TextSpan(
                              text: 'reservas@grupotalia.org',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Botón para acceder al soporte
                      ElevatedButton(
                        onPressed:
                            () => OpenLink.abrirEnlace(
                              "https://www.grupotalia.org/wp-content/uploads/2024/06/Como-comprar-un-nuevo-abono-24-25.pdf",
                            ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cardSilvia,
                          foregroundColor: AppColors.fondo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.010,
                            horizontal: screenWidth * 0.08,
                          ),
                        ),
                        child: Text(
                          "Ver la guía",
                          style: TextStyle(
                            fontSize: fontSize * 0.8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Metodo para generar cada beneficio con su icono
  Widget _buildBenefitItem(IconData icon, String title, String description) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.1;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.titulo, size: iconSize),
          SizedBox(width: screenWidth * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description, style: TextStyle(color: AppColors.texto)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
