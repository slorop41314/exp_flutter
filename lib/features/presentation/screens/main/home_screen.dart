import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_bloc/features/presentation/bloc/all_games/all_games_bloc.dart';
import 'package:new_flutter_bloc/features/presentation/bloc/all_games/bloc.dart';
import 'package:new_flutter_bloc/features/presentation/widgets/game_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllGamesBloc>(context)
      ..add(
        FetchAllGamesEvent(
          page: 1,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Example"),
      ),
      body: SafeArea(
        child: Container(
          child: BlocBuilder<AllGamesBloc, AllGamesState>(
            builder: (_, state) {
              if (state is AllGamesLoadedState) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final item = state.data[index];
                    return GamesCard(item: item);
                  },
                );
              } else if (state is AllGamesInitialState) {
                return CircularProgressIndicator.adaptive();
              } else if (state is AllGamesLoadingState) {
                return _buildLoading();
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    final list = [1, 2, 3];
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      children: list.map((el) => GameCardPlaceholder()).toList(),
    );
  }
}
