class TheaterModel {
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final String lat;
  final String lon;
  final String classType; // 'class' is a reserved word in Dart
  final String type;
  final int placeRank;
  final double importance;
  final String addressType;
  final String name;
  final String displayName;
  final List<double> boundingBox;

  TheaterModel({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.classType,
    required this.type,
    required this.placeRank,
    required this.importance,
    required this.addressType,
    required this.name,
    required this.displayName,
    required this.boundingBox,
  });

  factory TheaterModel.fromJson(Map<String, dynamic> json) {
    return TheaterModel(
      placeId: json['place_id'],
      licence: json['licence'],
      osmType: json['osm_type'],
      osmId: json['osm_id'],
      lat: json['lat'],
      lon: json['lon'],
      classType: json['class'],
      type: json['type'],
      placeRank: json['place_rank'],
      importance: (json['importance'] as num).toDouble(),
      addressType: json['addresstype'],
      name: json['name'],
      displayName: json['display_name'],
      boundingBox: (json['boundingbox'] as List<dynamic>)
          .map((e) => double.tryParse(e.toString()) ?? 0.0)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'licence': licence,
      'osm_type': osmType,
      'osm_id': osmId,
      'lat': lat,
      'lon': lon,
      'class': classType,
      'type': type,
      'place_rank': placeRank,
      'importance': importance,
      'addresstype': addressType,
      'name': name,
      'display_name': displayName,
      'boundingbox': boundingBox,
    };
  }
}
