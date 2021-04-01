import 'package:dio/dio.dart';
import 'package:new_flutter_bloc/core/network/api_provider.dart';
import 'package:new_flutter_bloc/features/data/datasources/games/games_local_data_source.dart';
import 'package:new_flutter_bloc/features/data/datasources/games/games_remote_data_source.dart';
import 'package:new_flutter_bloc/features/domain/entities/base/paginated_response.dart';
import 'package:new_flutter_bloc/features/domain/entities/game.dart';
import 'package:new_flutter_bloc/features/domain/repositories/games_repository.dart';

class GamesRepositoryImpl implements GamesRepository {
  final GamesRemoteDataSource remoteDataSource;
  final GamesLocalDataSource localDataSource;
  final ApiProvider apiProvider;

  GamesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.apiProvider,
  });

  @override
  Future<PaginatedResponse<List<Game>>> getAllGames() async {
    try {
      final response = await apiProvider.getAllGames();
      final PaginatedResponse<List<Game>> gamesData =
          PaginatedResponse.fromJson(
        response.data,
        (json) => (json as List).map((element) {
          return Game.fromJson(element);
        }).toList(),
      );
      return gamesData;
    } on DioError catch (e) {
      print(e.response?.data);
      return Future.error(e);
    }
  }

  @override
  Future<void> getUpcomingGames() async {
    // TODO: implement getUpcomingGames
    throw UnimplementedError();
  }
}
