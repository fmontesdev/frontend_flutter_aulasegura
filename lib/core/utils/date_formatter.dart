import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Formatea una fecha en formato "d 'de' MMMM 'de' y" con internacionalización (ejemplo: 5 de octubre de 2023)
String dateFormatter(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).toString(); // 'es', 'ca', 'en'
  final formatter = DateFormat.yMMMMd(locale);
  final formattedDate = formatter.format(date);

  return formattedDate;
}

// Formatea una fecha y hora en formato dd/MM/yy hh:mm con internacionalización (ejemplo: 05/10/23 14:30)
String dateTimeFormatter(BuildContext context, DateTime datetime) {
  final locale = Localizations.localeOf(context).toString(); // 'es', 'ca', 'en'
  final formatter = DateFormat.yMd(locale).add_Hm();
  final formattedDate = formatter.format(datetime);

  return formattedDate;
}

// Formatea una franja horaria en formato HH:mm - HH:mm (ejemplo: 14:30 - 15:30)
String timeReservation(DateTime startAt, DateTime endAt) {
  final formatter = DateFormat('HH:mm', 'es_ES');
  final formattedTime = '${formatter.format(startAt)} - ${formatter.format(endAt)}';

  return formattedTime;
}

// Formatea una hora en formato HH:mm (ejemplo: 14:30)
String timeFormatter(DateTime time) {
  final formatter = DateFormat('HH:mm', 'es_ES');
  final formattedTime = formatter.format(time);

  return formattedTime;
}