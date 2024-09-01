import 'package:get_it/get_it.dart';
import 'package:movie_mate/core/network/api_client.dart';
import 'package:movie_mate/features/home/data/data_sources/home_remote_data_provider.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //* data providers
  getIt.registerLazySingleton(()=> HomeDataProviderImpl(getIt()));
  //* Core
  getIt.registerLazySingleton(()=> ApiClient());
}