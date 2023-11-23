import 'package:flutter/material.dart';
import 'game_card.dart';

// ignore: must_be_immutable
class GameTable extends StatelessWidget {
  late List<String> _icons;

  GameTable({super.key, required List<String> icons}) {
    _icons = [...icons, ...icons];
    _icons.shuffle(); // Embaralha a lista
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 5,
        children: List.generate(
            _icons.length,
            (index) => GameCard(
                icon: Image.asset(
                    "assets/img/${_icons[index]}.png")) // Emite uma carta para cada ícone da lista
            ));
  }
}
