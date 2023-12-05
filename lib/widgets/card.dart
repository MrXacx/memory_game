import 'package:flutter/material.dart';
import 'package:memory_game/widgets/table.dart';

// ignore: must_be_immutable
class GameCard extends StatefulWidget {
  final Image icon;
  final GameTable observable;
  final Function onClick;
  final GameCardState _state = GameCardState();

  GameCard({
    super.key,
    required this.icon,
    required this.observable,
    required this.onClick,
  });

  GameCardState get state => _state;

  @override
  // ignore: no_logic_in_create_state
  State<GameCard> createState() => state;
}

class GameCardState extends State<GameCard> {
  static Image thumbnail = Image.asset('assets/img/background.png');
  bool fliped = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.onClick();
            move();
          });
        },
        child: fliped ? widget.icon : thumbnail,
      ),
    );
  }

  Future flip() => Future.delayed(const Duration(milliseconds: 200),
      () => setState(() => fliped = !fliped));
  void reset() => fliped = false;
  void move() {
    var engine = widget.observable.engine;
    // Executa se a carta não estiver virada e se a pilha não estiver cheia
    engine.move(this); // altera o estado da cara
  }
}
