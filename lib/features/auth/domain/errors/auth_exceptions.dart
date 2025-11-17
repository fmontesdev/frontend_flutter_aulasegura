/// Excepción base para errores de autenticación
class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}

/// Excepción cuando las credenciales son inválidas
class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException([super.message = 'Email o contraseña incorrectos']);
}

/// Excepción cuando hay problemas de red
class NetworkException extends AuthException {
  const NetworkException([super.message = 'Error de conexión']);
}

/// Excepción para errores inesperados
class UnexpectedException extends AuthException {
  const UnexpectedException([super.message = 'Error inesperado']);
}

/// Excepción cuando el token es inválido o ha expirado
class InvalidTokenException extends AuthException {
  const InvalidTokenException([super.message = 'Token inválido o expirado']);
}

/// Excepción cuando el token no se encuentra
class TokenNotFoundException extends AuthException {
  const TokenNotFoundException([super.message = 'Token no encontrado']);
}