import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/core/widgets/shimmer_loading.dart';
import 'package:movie_mate/features/movie_details/domain/entities/movie_image.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/movie_images_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/widgets/shimmer_screenshot.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 6),
          child: Text(
            LocaleKeys.screenshots.tr(),
            style: context.textStyle.titleMedium,
          ),
        ),
        BlocBuilder<MovieImagesCubit, CommonApiState>(
          builder: (context, state) {
            if (state is ApiInitial || state is ApiLoading) {
              return _createShimmerScreenshot(context, 6);
            } else if (state is ApiError) {
              return ErrorMessage(message: state.message);
            } else if (state is ApiSuccess) {
              return _createScreenshotView(context, state.response);
            } else {
              return const ErrorMessage(message: LocaleKeys.unknownError);
            }
          },
        ),
      ],
    );
  }

  Widget _createScreenshotView(BuildContext context, List<MovieImage> backdrops) {
    return SizedBox(
      height: context.width * 0.35,
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
    );
  }

  Widget _createShimmerScreenshot(BuildContext context, int length) {
    return SizedBox(
      height: context.width * 0.3,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return const ShimmerMovieScreenshot();
        },
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Colors.transparent,
          width: 6.0,
        ),
        itemCount: length,
      ),
    );
  }

  Widget _createScreenshotItem(BuildContext context, MovieImage img) {
    final width = context.width / 2.2;
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


