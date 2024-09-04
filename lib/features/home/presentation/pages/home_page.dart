import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mate/config/routes/router_manager.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/widgets/title_widget.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/domain/use_cases/search_movies.dart';
import 'package:movie_mate/features/home/presentation/blocs/movie_search_cubit.dart';
import 'package:movie_mate/features/home/presentation/widgets/movie_search_delegate.dart';
import 'package:movie_mate/features/home/presentation/widgets/upcoming_slider_view_widget.dart';
import 'package:movie_mate/features/home/presentation/widgets/trending_movies_widget.dart';
import 'package:movie_mate/features/movie_details/presentation/pages/movie_details_page.dart';


class HomePage extends StatelessWidget {
  static const String path = '/homepage';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieSearchCubit>(),
      child: Builder(
        builder: (context) {
          MovieSearchCubit searchCubit = context.read<MovieSearchCubit>();
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 4.0,
              //backgroundColor: context.theme.colorScheme.surface,
              title: const TitleWidget(),
              centerTitle: true,
              leading: Container(
                padding: const EdgeInsets.only(left: 16.0),
                child: IconButton(
                  icon: Icon(Icons.menu_rounded,
                      color: context.theme.appBarTheme.iconTheme!.color),
                  onPressed: () {},
                ),
              ),
              actions: [
                Container(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Icon(Icons.search,
                        color: context.theme.appBarTheme.iconTheme!.color),
                    onPressed: () {
                      showSearch(context: context, delegate: MovieSearchDelegate(searchCubit));
                    },
                  ),
                ),
              ],
              elevation: 0.0,
            ),
            backgroundColor: context.theme.scaffoldBackgroundColor,
            body: _createBody(context),
          );
        }
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Column(
          children: [
            UpcomingSliderView(
              onPressedMovie: (movie) {
                _navigateToMovieDetailPage(context, movie: movie);
              },
            ),
            const Divider(height: 6.0, color: Colors.transparent),
            Expanded(child: TrendingMoviesWidget(onPressedMovie: (movie) {
              _navigateToMovieDetailPage(context, movie: movie);
            },)),
          ],
        );
      },
    );
  }

  _navigateToMovieDetailPage(BuildContext context, {required Movie movie}) {
    context.push(MovieDetailsPage.path, extra: movie);
  }
}
