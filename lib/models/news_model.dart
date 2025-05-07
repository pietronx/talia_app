class Noticia {
  final String titulo;
  final String fecha;
  final String descripcion;
  final String portadaUrl;
  final String? linkMasInfo;
  final bool activo;

  Noticia({
    required this.titulo,
    required this.fecha,
    required this.descripcion,
    required this.portadaUrl,
    this.linkMasInfo,
    required this.activo,
  });
}
