class EventoDrive {
  final String tituloTxtUrl;
  final String descripcionTxtUrl;
  final String imagenUrl;
  final String? programaUrl;

  EventoDrive({
    required this.tituloTxtUrl,
    required this.descripcionTxtUrl,
    required this.imagenUrl,
    this.programaUrl,
  });
}