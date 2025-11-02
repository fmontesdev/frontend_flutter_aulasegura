// Normaliza cualquier cadena de texto
String normalizeString(String input) {
  final String string = input
    .toLowerCase()
    .replaceAll(' ', '_')
    .replaceAll('á', 'a')
    .replaceAll('à', 'a')
    .replaceAll('é', 'e')
    .replaceAll('è', 'e')
    .replaceAll('í', 'i')
    .replaceAll('ó', 'o')
    .replaceAll('ò', 'o')
    .replaceAll('ú', 'u')
    .replaceAll('ñ', 'n');

  return string;
}