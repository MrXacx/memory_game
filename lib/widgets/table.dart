import 'package:flutter/material.dart';
import 'package:memory_game/scripts/engine.dart';
import 'card.dart';

// ignore: must_be_immutable
class GameTable extends StatefulWidget {
  late GameEngine _engine; // Suporte ao funcionamento do jogo
  late List<GameCard> _observers;
  int moves = 0;
  GameTableState state =  GameTableState();

  GameTable({super.key, required List<String> icons}) {
    icons = [...icons, ...icons];

    _observers = List.generate(
        icons.length,
        (index) => GameCard(
              icon: Image.asset("assets/img/${icons[index]}.jfif"),
              observable: this,
              onClick: () => moves = _engine.movesCounter,
            ) // Emite uma carta para cada ícone da lista
        );

    _engine = GameEngine(this, _observers);
  }

  GameEngine get engine => _engine;

  @override
  // ignore: no_logic_in_create_state
  GameTableState createState() => state;
}

class GameTableState extends State<GameTable> {
  void reset() {
    // ignore: avoid_function_literals_in_foreach_calls
    widget._observers.forEach((e) => e.state.reset());
    widget._observers.shuffle();
    widget._engine.showCards();
  }

  @override
  Widget build(BuildContext context) {
    reset();
    return GridView.count(
      crossAxisCount: 5,
      children: widget._observers,
    );
  }
}
