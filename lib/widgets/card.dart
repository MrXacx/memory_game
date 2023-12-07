import 'package:flutter/material.dart';
import 'package:memory_game/widgets/table.dart';

// ignore: must_be_immutable
class GameCard extends StatefulWidget {
  final Image icon;
  final GameTable observable;
  final Function onTapFunction;
  final GameCardState _state = GameCardState();

  GameCard({
    super.key,
    required this.icon,
    required this.observable,
    required this.onTapFunction,
  });

  GameCardState get state => _state;

  @override
  // ignore: no_logic_in_create_state
  State<GameCard> createState() => state;
}

class GameCardState extends State<GameCard> {
  static Image thumbnail = Image.asset('assets/img/background.png');
  bool fliped = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      child: InkWell(
        onTap: move,
        child: fliped ? widget.icon : thumbnail,
      ),
    );
  }

  Future flip() => Future.delayed(const Duration(milliseconds: 200),
      () => setState(() => fliped = !fliped));

  void move() {
    var engine = widget.observable.engine;
    if (!fliped) {
      // Executa se a carta não estiver virada
      if (engine.move(this)) { // altera o estado da cara
        widget.onTapFunction();
      }
      
      //widget.onTapFunction();
    }
  }
}
