import "package:flutter/material.dart";
import "package:talia_app/helpScreens/help_previous_events.dart";

import "../customColors/app_colors.dart";
import "../data/previous_event_drive.dart";
import "../helpers/link_helper.dart";
import "../widgets/widgets_util.dart";

class PreviousEvents extends StatelessWidget {
  const PreviousEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anteriores Eventos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            color: AppColors.appbarIcons,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpPreviousEvents()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titulo
                WidgetsUtil.contenedorPersonalizado(
                  text: "Eventos para Recordar",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textoColor: AppColors.titulo,
                ),
                Divider(
                  height: 0.1,
                  indent: 30,
                  endIndent: 30,
                  thickness: 2,
                  color: AppColors.drawerCabecera,
                ),

                const SizedBox(height: 30),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: PreviousEventDrive.todos.length,
                  itemBuilder: (context, index) {
                    final evento = PreviousEventDrive.todos[index];

                    return FutureBuilder<List<dynamic>>(
                      future: Future.wait([
                        LinkHelper.descriptionDrive(evento.descripcionTxtUrl),
                        if (evento.tituloTxtUrl.isNotEmpty)
                          LinkHelper.cargarTituloYSubtitulo(evento.tituloTxtUrl)
                        else
                          Future.value(("Título no disponible", "")),
                      ]),

                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(height: 16),
                                Text(
                                  "Cargando evento ${index + 1}...",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (snapshot.hasError || snapshot.data == null) {
                          return const Text(
                            "Error al cargar los datos del evento",
                          );
                        }

                        final descripcion = snapshot.data![0] as String;
                        final (titulo, subtitulo) =
                            snapshot.data![1] as (String, String);

                        return WidgetsUtil.popupCard(
                          context: context,
                          titulo: titulo,
                          subtitulo: subtitulo,
                          imagenUrl: LinkHelper.linkDrive(evento.imagenUrl),
                          descripcion: descripcion,
                          programaUrl: evento.programaUrl,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
