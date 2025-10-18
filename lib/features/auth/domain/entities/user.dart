import 'package:equatable/equatable.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/role.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/department.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String avatar;
  final DateTime? validFrom;
  final DateTime? validTo;
  final DateTime? createdAt;
  final Role role;
  final Department? department;

  const User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.avatar,
    this.validFrom,
    this.validTo,
    this.createdAt,
    required this.role,
    this.department,
  });

  User copyWith({
    String? id,
    String? name,
    String? lastName,
    String? email,
    String? avatar,
    DateTime? validFrom,
    DateTime? validTo,
    DateTime? createdAt,
    Role? role,
    Department? department,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
    validFrom: validFrom ?? this.validFrom,
    validTo: validTo ?? this.validTo,
    createdAt: createdAt ?? this.createdAt,
    role: role ?? this.role,
    department: department ?? this.department,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    lastName,
    email,
    avatar,
    validFrom,
    validTo,
    createdAt,
    role,
    department
  ];
}