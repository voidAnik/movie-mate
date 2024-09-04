import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/features/nearby_theatre/data/models/location_model.dart';
import 'package:movie_mate/features/nearby_theatre/presentation/blocs/nearby_theatres_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyTheatersPage extends StatelessWidget {
  static const String path = '/nearby_theatres_page';

  const NearbyTheatersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<NearbyTheatresCubit>()..getNearbyTheatres(), // Initial call to fetch location and theaters
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Nearby Theaters',
            style: context.textStyle.titleMedium!.copyWith(
              fontSize: context.width * 0.05,
            ),
          ),
        ),
        body: BlocBuilder<NearbyTheatresCubit, CommonApiState>(
          builder: (context, state) {
            if (state is ApiLoading || state is ApiInitial) {
              return Center(
                child: CircularProgressIndicator(
                  color: context.theme.colorScheme.primary,
                ),
              );
            } else if (state is ApiError) {
              return ErrorMessage(message: state.message);
            } else if (state is ApiSuccess<LocationModel>) {
              final theaters = state.response.theaters;
              final position = state.response.position;

              return FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                    position.latitude,
                    position.longitude,
                  ),
                  initialZoom: 14.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.voidK.movie_meta',
                  ),
                  MarkerLayer(
                    markers: [
                      // User's current location marker
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(
                          position.latitude,
                          position.longitude,
                        ),
                        child:  const Icon(
                          Icons.my_location,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      ),
                      // Theater markers with popups
                      ...theaters.map((theater) {
                        return Marker(
                          width: context.width * 0.4,
                          height: context.width * 0.3,
                          point: LatLng(
                            double.parse(theater.lat),
                            double.parse(theater.lon),
                          ),
                          child:  Stack(
                            fit: StackFit.passthrough,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(theater.name, style: context.textStyle.titleSmall,),
                                        content: Text(theater.displayName, style: context.textStyle.bodySmall,),
                                        actions: [
                                          TextButton(
                                            child: const Text('Okay'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40.0,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    theater.name,
                                    textAlign: TextAlign.center,
                                    style: context.textStyle.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () => launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
