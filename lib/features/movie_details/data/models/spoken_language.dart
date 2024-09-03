import 'package:equatable/equatable.dart';

class SpokenLanguage extends Equatable {
  final String englishName;
  final String iso639_1;
  final String name;

  const SpokenLanguage({
    required this.englishName,
    required this.iso639_1,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'],
      iso639_1: json['iso_639_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'english_name': englishName,
      'iso_639_1': iso639_1,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [englishName, iso639_1, name];
}
