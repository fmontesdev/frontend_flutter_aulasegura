// Devuelve el día de la semana actual, donde 1 = Lunes y 5 = Viernes.
int dayOfTheWeek() {
  final dayOfWeek = DateTime.now().weekday; // 1..7
  return (dayOfWeek < 1 || dayOfWeek > 5) ? 1 : dayOfWeek;
}