import 'package:flutter/material.dart';
import 'package:new_flutter_bloc/core/constant/string.dart';
import 'package:new_flutter_bloc/features/domain/entities/game.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GamesCard extends StatelessWidget {
  const GamesCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Game item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Image.network(item.backgroundImage ?? imagePlaceholder),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item.name ?? "Title"),
          ),
        ],
      ),
    );
  }
}

class GameCardPlaceholder extends StatelessWidget {
  const GameCardPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 3), //Default value
      interval: Duration(
        seconds: 5,
      ), //Default value: Duration(seconds: 0)
      color: Colors.white, //Default value
      enabled: true, //Default value
      direction: ShimmerDirection.fromLTRB(), //Default Value
      child: Column(children: [
        Container(
          height: 200,
          color: Colors.grey[100],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 12,
            color: Colors.grey[100],
          ),
        )
      ]),
    );
  }
}
