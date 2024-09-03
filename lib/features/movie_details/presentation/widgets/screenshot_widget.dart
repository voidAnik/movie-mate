import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/movie_details/domain/entities/movie_image.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/movie_images_cubit.dart';

class ScreenshotViewWidget extends StatelessWidget {
  final int movieId;

  const ScreenshotViewWidget({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieImagesCubit>()..fetchImages(movieId: movieId),
      child: _createScreenshot(context),
    );
  }

  Widget _createScreenshot(BuildContext context) {
    return BlocBuilder<MovieImagesCubit, CommonApiState>(
      builder: (context, state) {
        if (state is ApiInitial || state is ApiLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ApiError) {
          return Text(state.message);
        } else if (state is ApiSuccess<List<MovieImage>>) {
          return _createScreenshotView(context, state.response);
        } else {
          return const Text('not supported');
        }
      },
    );
  }

  Widget _createScreenshotView(BuildContext context, List<MovieImage> backdrops) {
    final contentHeight = 2.0 * (MediaQuery.of(context).size.width / 2.2) / 3.0;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20.0, right: 16.0),
          height: 48.0,
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Screenshots',
                  style: TextStyle(
                    color: groupTitleColor,
                    fontSize: 16.0,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
        ),
        SizedBox(
          height: contentHeight,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _createScreenshotItem(context, backdrops[index]);
            },
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Colors.transparent,
              width: 6.0,
            ),
            itemCount: backdrops.length,
          ),
        ),
      ],
    );
  }

  Widget _createScreenshotItem(BuildContext context, MovieImage img) {
    final width = MediaQuery.of(context).size.width / 2.4;
    return Container(
      width: width,
      height: double.infinity,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          width: width,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CustomNetworkImage(
              imageUrl: img.filePath,
              width: width,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
