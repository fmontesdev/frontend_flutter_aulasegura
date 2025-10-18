import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final int id;
  final String name;

  const Role({
    required this.id,
    required this.name,
  });

  Role copyWith({
    int? id,
    String? name,
  }) => Role(
    id: id ?? this.id,
    name: name ?? this.name,
  );

  @override
  List<Object?> get props => [id, name];
}