import 'package:flutter/material.dart';
import 'game_card.dart';

class GameTable extends StatelessWidget {
  final _icons = <IconData>[Icons.plus_one];

  GameTable({super.key}) {
    _icons.addAll(_icons); // Duplica ícones
    _icons.shuffle(); // Embaralha a lista
  }

  @override
  Widget build(BuildContext context) => GridView.count(
      crossAxisCount: 6,
      children: List.generate(
          _icons.length,
          (index) => GameCard(
              icon: _icons[index]) // Emite uma carta para cada ícone da lista
          ));
}
