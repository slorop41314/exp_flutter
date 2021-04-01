import 'package:equatable/equatable.dart';
import 'package:new_flutter_bloc/features/domain/entities/game.dart';

abstract class AllGamesState extends Equatable {}

class AllGamesInitialState extends AllGamesState {
  @override
  List<Object> get props => [];
}

class AllGamesLoadingState extends AllGamesState {
  @override
  List<Object> get props => [];
}

class AllGamesLoadedState extends AllGamesState {
  final List<Game> data;

  AllGamesLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class AllGamesErrorState extends AllGamesState {
  final String message;

  AllGamesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
