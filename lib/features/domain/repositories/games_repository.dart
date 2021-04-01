import 'package:new_flutter_bloc/features/domain/entities/base/paginated_response.dart';
import 'package:new_flutter_bloc/features/domain/entities/game.dart';

abstract class GamesRepository {
  Future<PaginatedResponse<List<Game>>> getAllGames();
  Future<void> getUpcomingGames();
}
