import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_bloc/features/domain/repositories/games_repository.dart';
import 'package:new_flutter_bloc/features/presentation/bloc/all_games/all_games_bloc.dart';
import 'package:new_flutter_bloc/features/presentation/screens/main/list.dart';
import './injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di
      .init(); //Inject all the dependencies and wait for it is done (i.e. UI won't built until all the dependencies are injected)
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllGamesBloc>(
          create: (BuildContext context) => AllGamesBloc(
            repository: di.sl<GamesRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ExampleList(),
      ),
    );
  }
}
