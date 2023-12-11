import 'package:flutter/material.dart';
import 'package:memory_game/main.dart';
import 'package:memory_game/scripts/engine.dart';
import 'card.dart';

// ignore: must_be_immutable
class GameTable extends StatefulWidget {
  late GameEngine _engine; // Suporte ao funcionamento do jogo
  late List<GameCard> _observers;
  late final List<String> _icons;
  late GameTableState state;

  GameTable(
      {super.key, required List<String> icons, required Function onPressed,required Function onWin}) {
    _engine = GameEngine(icons.length, onWin);
    _icons = [...icons, ...icons];

    _observers = List.generate(
      _icons.length,
      (index) => GameCard(
        // Emite uma carta para cada ícone da lista
        icon: Image.asset("assets/img/${_icons[index]}.jfif"),
        observable: this,
        onTapFunction: onPressed,
      ),
    );

    state = GameTableState();
  }

  GameEngine get engine => _engine;

  @override
  // ignore: no_logic_in_create_state
  GameTableState createState() => state = state;
}

class GameTableState extends State<GameTable> {
  GameTableState() {
    initState();
  }

  void reInitialize() {
    widget._engine.flipAll();
    Future.delayed(
        const Duration(milliseconds: 300),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Home())));
  }

  Future showCards() => Future.sync(() {
        for (var e in widget._observers) {
          widget._engine.flip(e.state);
        }
      }).then((value) => Future.delayed(const Duration(seconds: 2), () {
            for (var e in widget._observers) {
              widget._engine.flip(e.state);
            }
          }));

  @override
  Widget build(BuildContext context) {
    widget._observers.shuffle();
    showCards().then((value) => widget.engine.turnPause());
    return GridView.count(
      crossAxisCount: 5,
      children: widget._observers,
    );
  }
}
