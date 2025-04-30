class AnteriorEvento {
  final String titulo;
  final String subtitulo;
  final String descripcion;
  final String imagenUrl;
  final String? programaUrl;
  final bool activo;

  AnteriorEvento({
    required this.titulo,
    required this.subtitulo,
    required this.descripcion,
    required this.imagenUrl,
    this.programaUrl,
    required this.activo,
  });
}