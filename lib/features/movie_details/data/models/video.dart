import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String iso639_1;
  final String iso3166_1;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  const Video({
    required this.iso639_1,
    required this.iso3166_1,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      iso639_1: json['iso_639_1'],
      iso3166_1: json['iso_3166_1'],
      name: json['name'],
      key: json['key'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
      official: json['official'],
      publishedAt: json['published_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_639_1': iso639_1,
      'iso_3166_1': iso3166_1,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'published_at': publishedAt,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [
    iso639_1,
    iso3166_1,
    name,
    key,
    site,
    size,
    type,
    official,
    publishedAt,
    id,
  ];
}
