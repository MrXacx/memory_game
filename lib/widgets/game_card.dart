import 'package:flutter/material.dart';
import 'package:memory_game/scripts/engine.dart';

// ignore: must_be_immutable
class GameCard extends StatefulWidget {
  final Image icon;
  final String name;
  final GameEngine engine;

  const GameCard({super.key, required this.name, required this.icon, required this.engine});

  @override
  State<GameCard> createState() => GameCardState();
}

class GameCardState extends State<GameCard> {
  static Image thumbnail = Image.asset('assets/img/background.png');
  bool fliped = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      child: InkWell(
        onTap: move,
        child: fliped ? widget.icon : thumbnail,
      ),
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
          Future.delayed(const Duration(milliseconds: 600), () {
            List<GameCardState> cards = widget.engine.cardStack.stack;

            cards[0].flip();
            cards[1].flip();
            widget.engine.cardStack.clear();
          });
        }
      }
    }
  }
}
