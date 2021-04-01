import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_bloc/features/domain/entities/base/paginated_response.dart';
import 'package:new_flutter_bloc/features/domain/entities/game.dart';
import 'package:new_flutter_bloc/features/domain/repositories/games_repository.dart';
import 'package:new_flutter_bloc/features/presentation/bloc/all_games/all_games_event.dart';
import 'package:new_flutter_bloc/features/presentation/bloc/all_games/all_games_state.dart';

class AllGamesBloc extends Bloc<AllGamesEvent, AllGamesState> {
  GamesRepository repository;

  AllGamesBloc({required this.repository})
      : super(
          AllGamesInitialState(),
        );

  AllGamesState get initialState => AllGamesInitialState();

  @override
  Stream<AllGamesState> mapEventToState(AllGamesEvent event) async* {
    if (event is FetchAllGamesEvent) {
      yield AllGamesLoadingState();
      try {
        PaginatedResponse<List<Game>> result = await repository.getAllGames();
        yield AllGamesLoadedState(data: result.results ?? []);
      } catch (e) {
        print(e);
        yield AllGamesErrorState(message: e.toString());
      }
    }
  }
}
