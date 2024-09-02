import 'package:movie_mate/features/home/domain/entities/genre.dart';

class GenreModel extends Genre{
  GenreModel({required super.id, required super.name});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
  
  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}