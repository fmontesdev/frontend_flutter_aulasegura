import 'package:equatable/equatable.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/role.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/department.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String avatar;
  final List<Role>? roles;
  final Department? department;
  final String? accessToken;
  final String? refreshToken;

  const User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.avatar,
    this.roles,
    this.department,
    this.accessToken,
    this.refreshToken,
  });

  User copyWith({
    String? id,
    String? name,
    String? lastName,
    String? email,
    String? avatar,
    List<Role>? roles,
    Department? department,
    String? accessToken,
    String? refreshToken,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
    roles: roles ?? this.roles,
    department: department ?? this.department,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    lastName,
    email,
    avatar,
    roles,
    department,
    accessToken,
    refreshToken,
  ];
}