import 'package:flutter/material.dart';
import 'package:memory_game/scripts/engine.dart';

// ignore: must_be_immutable
class GameCard extends StatefulWidget {
  final Image icon;
  final GameEngine engine;

  const GameCard({super.key, required this.icon, required this.engine});

  @override
  State<GameCard> createState() => GameCardState();
}

class GameCardState extends State<GameCard> {
  static Image thumbnail = Image.asset('assets/img/cow.png');
  bool fliped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: move,
      child: fliped ? widget.icon : thumbnail,
    );
  }

  void flip() => setState(() => fliped = !fliped);

  void move() {
    if (!(fliped || widget.engine.cardStack.isFull())) {
      // Executa se a carta não estiver virada e se a pilha não estiver cheia
      widget.engine.cardStack.add(this); // Adiciona carta
      flip(); // altera o estado da cara

      if (widget.engine.cardStack.isFull()) {
        // Executa se a pilha encheu após a última adição
        if (!widget.engine.isEquals()) {
          widget.engine.cardStack.stack.map((e) => e.flip());
          widget.engine.cardStack.clear();
        }
      }
    }
  }
}
