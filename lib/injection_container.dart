import 'package:get_it/get_it.dart';
import 'package:new_flutter_bloc/core/network/api_provider.dart';
import 'package:new_flutter_bloc/features/data/datasources/games/games_local_data_source.dart';
import 'package:new_flutter_bloc/features/data/datasources/games/games_remote_data_source.dart';
import 'package:new_flutter_bloc/features/data/repositories/games_repository_impl.dart';
import 'package:new_flutter_bloc/features/domain/repositories/games_repository.dart';
import 'package:new_flutter_bloc/features/presentation/bloc/all_games/all_games_bloc.dart';
import 'package:new_flutter_bloc/features/presentation/bloc/all_games/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<ApiProvider>(
    () => ApiProviderImpl(),
  );
  // Register Bloc
  sl.registerFactory(
    () => AllGamesBloc(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<GamesRepository>(
    () => GamesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      apiProvider: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<GamesLocalDataSource>(
    () => GamesLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<GamesRemoteDataSource>(
    () => GamesRemoteDataSourceImpl(),
  );
  // Others
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
