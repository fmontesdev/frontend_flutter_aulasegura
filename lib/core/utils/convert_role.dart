// Convierte los roles internos a nombres legibles en castellano
String convertRole(String role) {
  String roleName;
  switch (role) {
    case 'admin':
      roleName = 'Administrador';
      break;
    case 'teacher':
      roleName = 'Profesor';
      break;
    case 'janitor':
      roleName = 'Conserje';
      break;
    case 'support_staff':
      roleName = 'Personal auxiliar';
      break;
    default:
      roleName = role;
  }
  return roleName;
}