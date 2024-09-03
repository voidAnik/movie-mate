import 'package:equatable/equatable.dart';

class ProductionCountry extends Equatable {
  final String iso3166_1;
  final String name;

  const ProductionCountry({
    required this.iso3166_1,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso3166_1: json['iso_3166_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_3166_1': iso3166_1,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [iso3166_1, name];
}
