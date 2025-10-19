import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String dateFormatter(DateTime date) {
  // Inicializar los datos de localización
  initializeDateFormatting('es_ES', null);

  final formatter = DateFormat('d \'de\' MMMM \'de\' y', 'es_ES');
  final formattedDate = formatter.format(date);

  return formattedDate;
}

String dateTimeFormatter(DateTime date) {
  // Inicializar los datos de localización
  initializeDateFormatting('es_ES', null);

  final formatter = DateFormat('dd/MM/yy hh:mm', 'es_ES');
  final formattedDate = formatter.format(date);

  return formattedDate;
}