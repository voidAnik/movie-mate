import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_mate/core/network/api_client.dart';
import 'package:movie_mate/core/utils/network_info.dart';
import 'package:movie_mate/features/home/data/data_sources/home_local_data_provider.dart';
import 'package:movie_mate/features/home/data/data_sources/home_remote_data_provider.dart';
import 'package:movie_mate/features/home/data/repositories/home_repository_impl.dart';
import 'package:movie_mate/features/home/domain/repositories/home_repository.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_trending_movies.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_upcoming_movies.dart';
import 'package:movie_mate/features/home/presentation/blocs/get_trending_movies_cubit.dart';
import 'package:movie_mate/features/home/presentation/blocs/get_upcoming_movies_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {

  //* Core
  getIt
    ..registerLazySingleton(()=> ApiClient())
    ..registerLazySingleton(()=> InternetConnectionChecker())
    ..registerLazySingleton<NetworkInfo>(()=> NetworkInfoImpl(getIt()));

  //* data providers
  getIt..registerLazySingleton<HomeRemoteDataProvider>(()=> HomeRemoteDataProviderImpl(getIt()))
  ..registerLazySingleton<HomeLocalDataProvider>(()=> HomeLocalDataProviderImpl());

  //* Repositories
  getIt.registerLazySingleton<HomeRepository>(()=> HomeRepositoryImpl(getIt(), getIt(), getIt()));

  //* Use Cases
  getIt
    ..registerLazySingleton(()=> GetTrendingMovies(getIt()))
    ..registerLazySingleton(()=> GetUpcomingMovies(getIt()));

  //* Use Cases
  getIt
    ..registerLazySingleton(()=> GetTrendingMoviesCubit(getIt()))
    ..registerLazySingleton(()=> GetUpcomingMoviesCubit(getIt()));





}