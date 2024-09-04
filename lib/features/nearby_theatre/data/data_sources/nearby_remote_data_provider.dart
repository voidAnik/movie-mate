import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/core/network/api_client.dart';
import 'package:movie_mate/core/network/return_response.dart';
import 'package:movie_mate/features/nearby_theatre/data/models/theatre_model.dart';

class NearbyRemoteDataProvider{
  final ApiClient apiClient;

  NearbyRemoteDataProvider(this.apiClient);

  Future<List<TheaterModel>> fetchTheaters(Position position) async {
      final response = await apiClient.get(
        'https://nominatim.openstreetmap.org/search.php',
        queryParameters: {
          'q': 'theater',
          'format': 'json',
          'limit': 10,
          'lat': position.latitude,
          'lon': position.longitude,
          'countrycodes': 'BD',
        },
      );

      /*if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return (response.data as List).map<Marker>((theater) {
          return Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(
              double.parse(theater['lat']),
              double.parse(theater['lon']),
            ),
            child: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40.0,
            ),
          );
        }).toList();
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        throw ApiException(error: response.data['status_message']);
      } else {
        throw ServerException();
      }*/
      return ReturnResponse<List<TheaterModel>>()(response,
              (data) => (data as List)
              .map((json) => TheaterModel.fromJson(json))
              .toList());

  }
}