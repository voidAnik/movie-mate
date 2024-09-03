import 'package:equatable/equatable.dart';

class ProductionCompany extends Equatable {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  const ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
