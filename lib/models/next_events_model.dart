class ProximoEvento {
  final String titulo;
  final String subtitulo;
  final String descripcion;
  final String fecha;
  final String lugar;
  final String portadaUrl;
  final String? linkEntradas;
  final String? linkMasInfo;
  final bool activo;

  ProximoEvento({
    required this.titulo,
    required this.subtitulo,
    required this.descripcion,
    required this.fecha,
    required this.lugar,
    required this.portadaUrl,
    this.linkEntradas,
    this.linkMasInfo,
    required this.activo,
  });
}
