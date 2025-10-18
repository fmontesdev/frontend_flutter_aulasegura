import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final int id;
  final String name;

  const Department({
    required this.id,
    required this.name,
  });

  Department copyWith({
    int? id,
    String? name,
  }) => Department(
    id: id ?? this.id,
    name: name ?? this.name,
  );

  @override
  List<Object?> get props => [id, name];
}