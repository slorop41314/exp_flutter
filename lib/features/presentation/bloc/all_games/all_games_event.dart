import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AllGamesEvent extends Equatable {
  AllGamesEvent([List props = const <dynamic>[]]) : super();
}

class FetchAllGamesEvent extends AllGamesEvent {
  final int page;

  FetchAllGamesEvent({required this.page});

  @override
  List<Object?> get props => [];
}
