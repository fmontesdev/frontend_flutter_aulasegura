class AcademicYearModel {
  final int id;
  final String code;
  final bool isActive;

  const AcademicYearModel({
    required this.id,
    required this.code,
    required this.isActive,
  });

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) => AcademicYearModel(
    id: json['academicYearId'] as int,
    code: json['code'] as String,
    isActive: json['isActive'] as bool,
  );

  Map<String, dynamic> toJson() => {
    'academicYearId': id,
    'code': code,
    'isActive': isActive,
  };
}