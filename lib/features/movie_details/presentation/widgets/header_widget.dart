import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/movie_details_cubit.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderWidget extends StatelessWidget {
  final Movie movie;
  const HeaderWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: context.width * 0.8 + 56,
      child: Stack(
        children: [
          ShapeOfView(
            shape: ArcShape(
              direction: ArcDirection.Outside,
              height: 48,
              position: ArcPosition.Bottom,
            ),
            height: context.width * 0.8,
            elevation: 24.0,
            child: SizedBox(
              child: _createHeaderImage(context),
            ),
          ),
          _createHeaderAction(context),
        ],
      ),
    );
  }


  Widget _createHeaderImage(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: movie.id,
          child: CustomNetworkImage(
            imageUrl: movie.backdropPath,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.5, 0.7, 0.9],
              colors: [
                white20,
                white10,
                white05,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _createHeaderAction(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, CommonApiState>(
      builder: (context, state) {
        MovieDetailsModel? movieInfo;
        if(state is ApiSuccess){
          movieInfo = state.response;
        }
        return Positioned(
          bottom: 8.0,
          child: Container(
            width: context.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _headerIcon(context, icon: const Icon(Icons.add_rounded),
                onPressed: (){}),
                FractionalTranslation(
                  translation: const Offset(0.0, -0.2),
                  child: SizedBox(
                    width: context.width * 0.17,
                    height:  context.width * 0.17,
                    child: FittedBox(
                      child: FloatingActionButton(
                        elevation: 10.0,
                        onPressed: () {
                          if(movieInfo != null) {
                            _openYouTubeVideo(movieInfo.videos.first.key);
                          }
                        },
                        backgroundColor: white,
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                _headerIcon(context, icon:  const Icon(Icons.share_outlined),
                    onPressed: (){}),
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox _headerIcon(BuildContext context, {required VoidCallback onPressed, required Icon icon}) {
    return SizedBox(
                width: context.width * 0.15,
                height:  context.width * 0.15,
                child: FittedBox(
                  child: IconButton(
                    icon: icon,
                    onPressed: onPressed,
                  ),
                ),
              );
  }

  Future<void> _openYouTubeVideo(String videoKey) async {
    final url = Uri.parse('https://www.youtube.com/watch?v=$videoKey');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
