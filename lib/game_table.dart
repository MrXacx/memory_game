import 'package:flutter/material.dart';
import 'game_card.dart';

class GameTable extends StatelessWidget {
  static final _icons = <IconData>[
    Icons.plus_one,
    Icons.abc,
    Icons.access_time,
    Icons.account_balance,
  ];

  const GameTable({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [..._icons, ..._icons]; // Duplica ícones
    icons.shuffle(); // Embaralha a lista

    return GridView.count(
      crossAxisCount: 6,
      children: List.generate(
          icons.length,
          (index) => GameCard(icon: icons[index]) // Emite uma carta para cada ícone da lista
        ));
  }
}
