/// Excepción base para errores del módulo Access
abstract class AccessException implements Exception {
  final String message;
  const AccessException(this.message);

  @override
  String toString() => message;
}
