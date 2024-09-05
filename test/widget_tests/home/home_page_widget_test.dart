/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movie_mate/features/home/presentation/blocs/movie_search_cubit.dart';
import 'package:movie_mate/features/home/presentation/pages/home_page.dart';
import 'package:movie_mate/features/home/presentation/blocs/upcoming_movies_cubit.dart';
import 'package:movie_mate/features/home/presentation/widgets/app_drawer.dart';
import 'package:movie_mate/features/home/presentation/widgets/movie_search_delegate.dart';
import 'package:movie_mate/features/home/presentation/widgets/slider_item_widget.dart';
import 'package:movie_mate/features/home/presentation/widgets/trending_movies_widget.dart';
import 'package:movie_mate/features/home/presentation/widgets/upcoming_slider_view_widget.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_mate/core/widgets/title_widget.dart';
import 'package:movie_mate/core/injection/injection_container.dart' as di;

import 'home_page_widget_test.mocks.dart';


@GenerateMocks([MovieSearchCubit, UpcomingMoviesCubit])
void main() {
  setUp(() async {
    // Initialize GetIt
   //await di.init();
  });

  testWidgets('renders HomePage with widgets', (WidgetTester tester) async {
    // Mock cubits
    final mockMovieSearchCubit = MockMovieSearchCubit();
    final mockUpcomingMoviesCubit = MockUpcomingMoviesCubit();

    // Build HomePage with mock cubits
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MovieSearchCubit>(
          create: (context) => mockMovieSearchCubit,
          child: BlocProvider<UpcomingMoviesCubit>(
            create: (context) => mockUpcomingMoviesCubit,
            child: HomePage(),
          ),
        ),
      ),
    );

    // Verify if widgets are present
    expect(find.byType(AppDrawer), findsOneWidget);
    expect(find.byType(TitleWidget), findsOneWidget);
    expect(find.byType(UpcomingSliderView), findsOneWidget);
    expect(find.byType(TrendingMoviesWidget), findsOneWidget);

    // Test for the search icon button
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Verify initial state
    expect(find.text('Upcoming'), findsOneWidget); // Check for static text or other identifiers
  });

  testWidgets('search button opens search delegate', (WidgetTester tester) async {
    // Mock cubits
    final mockMovieSearchCubit = MockMovieSearchCubit();
    final mockUpcomingMoviesCubit = MockUpcomingMoviesCubit();

    // Build HomePage with mock cubits
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MovieSearchCubit>(
          create: (context) => mockMovieSearchCubit,
          child: BlocProvider<UpcomingMoviesCubit>(
            create: (context) => mockUpcomingMoviesCubit,
            child: HomePage(),
          ),
        ),
      ),
    );

    // Tap the search icon
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Check if search delegate is opened
    // Since you are using `showSearch` with MovieSearchDelegate, verify if it is shown
    expect(find.byType(MovieSearchDelegate), findsOneWidget);
  });

  testWidgets('clicking on a movie navigates to MovieDetailsPage', (WidgetTester tester) async {
    // Mock cubits
    final mockMovieSearchCubit = MockMovieSearchCubit();
    final mockUpcomingMoviesCubit = MockUpcomingMoviesCubit();

    // Build HomePage with mock cubits
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MovieSearchCubit>(
          create: (context) => mockMovieSearchCubit,
          child: BlocProvider<UpcomingMoviesCubit>(
            create: (context) => mockUpcomingMoviesCubit,
            child: HomePage(),
          ),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == '/movie_details') {
            return MaterialPageRoute(builder: (_) => Scaffold(body: Text('Movie Details Page')));
          }
          return null;
        },
      ),
    );

    // Mock movie data
    final movie = MovieModel(
      id: 1,
      title: 'Test Movie',
      originalTitle: 'Test Movie',
      overview: 'Test Overview',
      posterPath: 'path/to/poster',
      backdropPath: 'path/to/backdrop',
      genreIds: [1],
      popularity: 10.0,
      releaseDate: '2024-01-01',
      voteAverage: 8.0,
      voteCount: 100,
      adult: false,
      video: false,
      originalLanguage: 'en',
    );

    // Trigger the navigation
    await tester.tap(find.byType(SliderItemWidget).first);
    await tester.pumpAndSettle();

    // Verify navigation to MovieDetailsPage
    expect(find.text('Movie Details Page'), findsOneWidget);
  });
}
*/
