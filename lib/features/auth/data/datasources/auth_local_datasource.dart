// ignore_for_file: prefer_final_fields

import 'package:frontend_flutter_aulasegura/features/auth/data/models/user_model.dart';

class AuthLocalDataSource {
  List<UserModel> _userList = [];

  // Constructor que recibe datos de usuario simulados
  AuthLocalDataSource({required List<Map<String, dynamic>> seed})
    : _userList = seed.map(UserModel.fromJson).toList();

  Future<UserModel> fetchByEmail(String email) async {
    return _userList.firstWhere((user) => user.email == email);
  }
}